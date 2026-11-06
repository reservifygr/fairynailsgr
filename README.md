# Fairynails Agia Paraskevi — editorial multipage demo

**A Reservify sales presentation, not an official Fairynails website.**

Site: https://reservifygr.github.io/fairynailsgr/

## Design references
- [Nailsy 128](https://webflow.com/templates/html/nailsy-128-beauty-website-template) for editorial layout, menu and service hierarchy (not copied).
- [MELT Nail Studio](https://www.l30creatives.com/work/melt-nail-studio) for appointment-first UX.
- Official brand, phone, address and opening hours: https://fairynails.gr/our-locations-2/
- Brand service categories: https://fairynails.gr/en/our-services/
- Public Google review excerpts; verify source in the Google business listing before client use.

## Photography sources and scope
- High-resolution **Pexels free-license photographs** with source IDs 39919261 (Dulce Panebra), 35031987 (Salim Da), 31642925 (Jing Chang), 34871553 (Salim Da), 34930141 and 34930100 (José Antonio Otegui Auzmendi).
- Fairynails *other-branch* salon photography from published Treatwell listings (Nea Erythraia and The Mall Athens). Require approval for commercial use.
- Fairynails wordmark directly from the official website. Do not assume franchise permission for live commercial use.
- No photos are presented as verified images of the Agia Paraskevi location.
- External hotlinked images can be removed or change; **approved images should be stored in the repo** for a real launch.

## Pages
- `index.html` — editorial homepage, signature service selections, visual and review carousels.
- `services.html` — category filters, services, editable sample durations and unpublished sample prices.
- `gallery.html` — photos with proper source disclosures.
- `about.html` — brand experience and location story.
- `contact.html` — published branch details, hours and map.
- `booking.html` — functioning **local-only simulation** of an appointment request.
- `admin.html` — simulated manager/staff views with local reservation statuses, service availability, demo pricing, durations, and cancellation.

All pages support Greek and English, sticky responsive nav and animated brand-star preloader. Motion respects `prefers-reduced-motion`.

## Important demo-only limitations
1. **No backend**, real appointments, SMS, emails or payments. Customer inputs stay in the browser's localStorage, so use fictional demonstration data only.
2. **Staff roles are a preview, not a secure login.** Switching manager/staff is not authentication. Do not use for real appointments.
3. Availability and appointment capacities are illustrative; date limits, sample duration and displayed slots are not connected to real staff calendars. Operational hours are drawn from the brand's public location page and should be confirmed.
4. The carousel contains selected genuine Google customer review excerpts, **not a live Google API integration**. Obtain source confirmation for launch.
5. The visual feed consists of photos, **not a real branch Instagram integration**. The verified business account must be provided to build one.
6. Visible sample prices start blank — never invent a branch-specific price list.

## Actual production system architecture
A draft, **not deployed** RLS-first PostgreSQL schema exists in `supabase/PROPOSED_SCHEMA.sql`.

Before creating real reservations:
- Create a new **dedicated** Supabase project for Fairynails (never use unrelated client or Reservify CRM data).
- Configure Supabase Auth staff invitations and roles with secure RLS, account recovery and signed-out behavior.
- Add a server-side booking endpoint with availability conflict protection, rate limiting, CAPTCHA/anti-spam and validation; **never allow anonymous inserts into private appointments table directly**.
- Configure per-staff calendars, service staffing requirements, breaks, closures, buffers and duration constraints.
- Add GDPR privacy notice, retention/deletion, consent where needed, and appropriate booking notifications.
- Confirm real prices, duration, team names/permissions and written franchise brand asset approval.
- Replace external photos with approved, locally hosted assets.
- Connect reviews and social media using authorized feeds and rate limits, or use verified manually curated content.
- Remove demo disclosures **only after** production services work and pass security/booking tests.

## Testing
On every PR, GitHub Actions runs JavaScript syntax, static page checks and Playwright desktop/mobile E2E tests with screenshots.
Run locally using a static server: `python3 -m http.server 8123`, then open `http://localhost:8123/`.

No Lovable credits, Webflow template purchase or TinyFish fees are required.
