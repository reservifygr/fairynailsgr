# Fairynails Agia Paraskevi — Reservify demo

**Unofficial sales concept, not the official Fairynails website.** Designed for an introductory meeting with the Agia Paraskevi branch owner.

## What's included
- Responsive, editorial one-page site (Greek primary / English switch).
- Branch contact and location; official Fairynails imagery and logo credited as chain-wide illustrative material (not falsely identified as photos of this specific branch).
- Indicative service categories, without invented prices or invented employees.
- Interactive booking *simulation*: service, date (next 60 days), example times, name, phone and notes.
- Accessible booking confirmation. No email, no payment, no database and no real appointments.
- Expandable "Salon demo view" on the same browser, with local demo bookings and a cancel control.
- Demonstration and privacy disclosures; noindex metadata.

## Deployment
This repository is deliberately plain HTML/CSS/JavaScript and has no build step or Lovable dependencies.

To activate a GitHub Pages public preview:
1. Open **Settings → Pages** for this repository.
2. Under **Build and deployment**, choose **Deploy from a branch**.
3. Select **main** and **/(root)** and Save.
4. When GitHub reports deployment, visit **https://reservifygr.github.io/fairynailsgr/**.

If the repo is public, GitHub Pages may be accessible to anyone who knows the link. The page uses `noindex` to discourage search indexing, but it is **not private**. Keep sample names and phone numbers fictional.

## Demo walkthrough
1. Switch between Greek and English.
2. Click any service card to preselect it in the appointment flow.
3. Select a future weekday and a demo time.
4. Enter fictional contact details, tick the demo acknowledgment, and complete booking.
5. Expand "Salon demo view" to show the appointment. Cancel it to demonstrate staff control.
6. Reload the page to show local browser-only persistence.

## Before any real launch
- Obtain any required chain/brand approvals, licenses and photography usage permissions; owner permission to make a demo does not by itself establish chain-wide rights for commercial launch.
- Confirm exact service list, actual service durations/prices, salon hours and staff availability.
- Confirm whether bookings are controlled centrally by Fairynails or a third-party booking provider.
- Build genuine server-side availability, validation, concurrency protection, administrator authentication, and secure data handling. LocalStorage is **not** appropriate for real customer data.
- Implement GDPR policy, consent where required, retention/deletion practices and real booking confirmations.
- Replace brand-chain images with authorized photographs of the specific Agia Paraskevi location.
- Remove demo labels only after the system actually supports real reservations.

## Source
- Official brand: https://fairynails.gr/
- Built for Reservify demonstration: https://reservify.gr/

© Fairynails brand assets belong to their respective rights holders. This is a noncommercial concept and not an officially launched branch website.
