-- DESIGN-ONLY MIGRATION. NOT APPLIED TO ANY LIVE DATABASE.
-- Fairynails must receive its own dedicated Supabase project. Review and test before production.
-- Customer-facing anonymous bookings require a separate rate-limited server endpoint.
create extension if not exists pgcrypto;

create table if not exists public.fairy_staff (
  user_id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null check (char_length(full_name) between 2 and 120),
  role text not null check (role in ('manager','staff')),
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.fairy_services (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  title_gr text not null,
  title_en text not null,
  duration_minutes int not null check (duration_minutes between 15 and 240),
  price_eur numeric(8,2) check (price_eur is null or price_eur >= 0),
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.fairy_appointments (
  id uuid primary key default gen_random_uuid(),
  service_id uuid not null references public.fairy_services(id),
  staff_id uuid references public.fairy_staff(user_id),
  starts_at timestamptz not null,
  ends_at timestamptz not null,
  customer_name text not null check (char_length(customer_name) between 2 and 120),
  customer_phone text not null check (char_length(customer_phone) between 7 and 25),
  customer_notes text check (customer_notes is null or char_length(customer_notes) <= 1000),
  status text not null default 'pending' check (status in ('pending','confirmed','completed','cancelled')),
  created_at timestamptz not null default now(),
  check (ends_at > starts_at)
);

create index if not exists fairy_appointments_starts_idx on public.fairy_appointments(starts_at);
create index if not exists fairy_appointments_staff_idx on public.fairy_appointments(staff_id);
create index if not exists fairy_staff_role_idx on public.fairy_staff(role,is_active);

alter table public.fairy_staff enable row level security;
alter table public.fairy_services enable row level security;
alter table public.fairy_appointments enable row level security;

revoke all on public.fairy_staff from anon,authenticated;
revoke all on public.fairy_services from anon,authenticated;
revoke all on public.fairy_appointments from anon,authenticated;

grant select on public.fairy_staff to authenticated;
grant select,insert,update on public.fairy_services to authenticated;
grant select on public.fairy_services to anon;
grant select,insert,update on public.fairy_appointments to authenticated;

-- Staff members can see only their own membership. Creation/role management
-- must be performed by a trusted administrator, never by a browser session.
create policy fairy_staff_read_own on public.fairy_staff for select to authenticated
using (user_id = (select auth.uid()));

create policy fairy_services_public_read on public.fairy_services for select to anon,authenticated
using (is_active or exists (
  select 1 from public.fairy_staff s
  where s.user_id = (select auth.uid()) and s.is_active
));

create policy fairy_services_manager_insert on public.fairy_services for insert to authenticated
with check (exists (
  select 1 from public.fairy_staff s
  where s.user_id = (select auth.uid()) and s.role='manager' and s.is_active
));

create policy fairy_services_manager_update on public.fairy_services for update to authenticated
using (exists (
  select 1 from public.fairy_staff s
  where s.user_id = (select auth.uid()) and s.role='manager' and s.is_active
))
with check (exists (
  select 1 from public.fairy_staff s
  where s.user_id = (select auth.uid()) and s.role='manager' and s.is_active
));

create policy fairy_appointments_staff_read on public.fairy_appointments for select to authenticated
using (exists (
  select 1 from public.fairy_staff s
  where s.user_id = (select auth.uid()) and s.is_active
  and (s.role = 'manager' or public.fairy_appointments.staff_id = s.user_id)
));

create policy fairy_appointments_staff_insert on public.fairy_appointments for insert to authenticated
with check (exists (
  select 1 from public.fairy_staff s
  where s.user_id = (select auth.uid()) and s.is_active
  and (s.role = 'manager' or public.fairy_appointments.staff_id = s.user_id)
));

create policy fairy_appointments_staff_update on public.fairy_appointments for update to authenticated
using (exists (
  select 1 from public.fairy_staff s
  where s.user_id = (select auth.uid()) and s.is_active
  and (s.role = 'manager' or public.fairy_appointments.staff_id = s.user_id)
))
with check (exists (
  select 1 from public.fairy_staff s
  where s.user_id = (select auth.uid()) and s.is_active
  and (s.role = 'manager' or public.fairy_appointments.staff_id = s.user_id)
));

-- Security notes:
-- * No anonymous writes to appointments. Use a dedicated Edge Function with
--   CAPTCHA, rate limits, input checks and transactional availability validation.
-- * Never embed Supabase service_role / secret key in the GitHub Pages bundle.
-- * Add overlap/concurrency constraints and booking conflict tests before go-live.
-- * Never use client editable user_metadata for permissions.
-- * Run Supabase database advisors and RLS tests before deployment.
