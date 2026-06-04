# Positioning Realignment — Design

**Date:** 2026-06-04
**Owner:** Steve Regester
**Goal:** Realign the professional brand site (and add a résumé) to land a **founding / early-engineer role** at an early-stage company.

---

## Problem

The site is built and written as a **consulting service menu** — OSINT surveillance, penetration testing, N8N automation, fractional CTO, full-stack — wrapped in generic "Transform Your Business / Proven Results / Free Consultation" copy, SEO-stuffed titles, anonymous testimonials ("Technology Executive, Enterprise Client"), and unverifiable metrics ("60%+ growth," "doubled productivity," "40% cost reduction").

This works against the actual goal. For a founding-engineer **role** (not gigs), this positioning reads as "contractor who wants work," dilutes a strong real identity across five unrelated services, and — most damagingly — pairs fabricated numbers with a real name, which becomes a liability in interviews.

Meanwhile the candidate's genuine track record and writing voice tell a far stronger, internally consistent story that is currently hidden.

## The real identity (the throughline)

Across 18 named references spanning 2012–2026, colleagues independently describe the same person:

- **Craftsman / quality obsession** — "the high-water mark for front-end engineering talent" (Derek Halliday, now CPO @ Benchling); "doesn't settle for mediocre code… beautiful, clear, best-practice code" (Christina Wright); "refines his work after the point most people would consider done" (Nathan Smith).
- **Right-sized solutions / judgment** — "always pushed for the right solution first" (Christophe Verbinnen, now Principal Architect @ KnowBe4); "iterates on the most appropriate technical solution until implemented with the necessary precision" (Alex Tsibulya); "mastered the art of asking the right questions to reach the right solutions" (Christina Wright). This is the same thesis as the essay *The Feel of Software*.
- **0→1 builder / architect** — led a complete Windows→cloud-native web rewrite and the company's first SOC 2 at Studylog; built the product, API, IaC, and core ingestion system at Delphos.
- **Elevates teams** — "culture of intellectual vulnerability" (Christina); strong mentor language from Hector, Jesse, Steven.
- **Security/intelligence domain** — entire career at security/intelligence companies (Lookout, Synack, Delphos). Domain context, *not* a surveillance/pentest service.
- **AI-native now** — "specification over syntax" thesis (*Code Was Always a Barrier*); building AI-driven binary analysis at Delphos.

**Insight:** the brand doesn't need to be invented — it needs to stop hiding behind a service menu.

## Decisions (locked with Steve)

| Decision | Choice |
| --- | --- |
| Primary goal | Land a **founding / early-engineer role** (employee-track, deep commitment, wide scope) |
| Consulting service pages | **Delete all** — clean break |
| Voice | **Lead with the real voice** — candid, low-key confident, craft-focused (lowercase/introspective tone permitted) |
| Résumé artifact | **On-site `/resume` page + generated PDF** |
| Hero direction | **B** — "15 years building high-quality software in hard domains; looking for the next thing to build from the ground up." Experience-forward, explicit about seeking. |
| Ultimatum | **Co-Founder / CTO, full stack** — frame as a real founding role (built the whole platform solo); don't dwell on outcome |
| Security thread | **Domain context, not a service** — "built products AT security/intelligence companies" (Lookout, Synack, Delphos) |
| Capabilities to lead with | 0→1 product building · full-stack craft + judgment · AI-native engineering · security mindset (subordinated) |

## Scope

### A. Deletions
- `startup-consulting.md`
- `fullstack-engineering.md`
- `n8n-consulting.md`
- `penetration-testing.md`
- `osint-solutions.md`
- `faq.md` (consulting FAQ — remove)
- Keep the `service` **layout** itself — `about.md` and `projects.md` reuse it.
- `_includes/service-structured-data.html` emits Google **Service** schema and is gated in `_layouts/default.html` by `{% if page.type == 'service' %}`. The deleted pages and **`index.md`** carry `type: service`. Changing `index.md`'s `type` to `profile` (or removing it) stops the wrong Service schema from rendering on the homepage; once no page has `type: service`, the include is dead and can be deleted. (`about.md` = `profile`, `projects.md` = `portfolio` already.)

### B. Navigation (`_includes/navigation.html`)
- Remove the entire "Services" dropdown (and its desktop hover JS if now unused).
- New nav order: **Home · About · Work · Writing · Résumé · Contact**
  - "Work" → `/projects` (relabeled), "Writing" → `/blog`, "Résumé" → `/resume`.
- Update `_config.yml` `navigation:` keys accordingly.

### C. Homepage (`index.md`) — rebuild
1. **Hero** (direction B): name, one-line positioning, the "looking for…" line, headshot.
2. **Who I am** — short first-person narrative in Steve's voice (not a service grid). Craft + right-sized solutions + 0→1, anchored in lived experience.
3. **What I've built** — 4–6 real selected works (Studylog SOC 2 rewrite, Delphos ingestion/AI, Synack platform, Lookout tools + OraculumJS/FactoryJS, a side project or two). Link to Work page.
4. **What people say** — 4–6 **real, named** testimonials with current titles/companies. Suggested set: Derek Halliday (CPO, Benchling), Christophe Verbinnen (Principal Architect, KnowBe4), Faye Salwin (Delphos), Brad Nemer (Studylog / SOC 2), Christina Wright, Mikko Tervahauta (Staff, Oura).
5. **CTA** — role-seeking, not consultation-selling: "I'm looking for founding/early-engineer roles. Here's how to reach me." + résumé link + email.
- Remove "Proven Results Across All Services," the buzzword "Comprehensive Technology Expertise" grid, and all consultation CTAs.
- Update `<title>`/meta/keywords from consultant SEO to name + founding-engineer framing.

### D. About (`about.md`) — rewrite
- Rewrite front-matter `hero` / `value_prop` / `services` / `cta` and body in Steve's voice.
- Real arc: PBworks → Lookout → Synack → Ultimatum → Studylog → Delphos.
- Theme: craft, right-sized solutions, elevating teams, security/intelligence domain context.
- **Remove** the three anonymous testimonials and the unverifiable stats ("60%+ Growth," "Doubled… productivity"). Replace testimonials with real named ones (can share a curated set with the homepage).
- Convert "Core Consulting Expertise" to "How I work / What I'm good at" framed as capability, not services for sale.
- **Fix tense:** the current `value_prop` says "Currently at Delphos Labs leading binary analysis with AI." Delphos ended Mar 2026 → rewrite to past tense ("most recently, employee #1 at Delphos…") and frame Steve as seeking the next 0→1. Apply the same fix anywhere the homepage implies a current Delphos role.

### E. Work (`projects.md`) — reframe
- Reframe hero/value_prop/cta from "consulting case studies" to "things I've built."
- Replace the fabricated `<article>` case studies (with invented metrics) with honest descriptions.
- Keep the `projects.yml` grid. **Keep** the LinkedIn-backed metrics (Synack ARS ">60% engagement," Lookout "doubled / 100% productivity") — these are Steve's own claims. **Strip** only the site-invented ones with no provenance (see Honesty pass).
- Remove service-page CTA links ("View OSINT Solutions →", "Security Services →", etc.).

### F. Résumé (`resume.md` + PDF) — new
- New `/resume` page, print-optimized (clean print stylesheet; screen view matches site).
- Content from confirmed real history (LinkedIn-accurate titles, dates, metrics):
  - **Delphos Labs** — Founding / Staff Software Engineer (Jul 2024 – Mar 2026). Employee #1 at a VC-backed cybersecurity startup using AI to automate binary reverse engineering; built the core company & product 0→1. Designed platform architecture (SaaS, automation pipelines, DB, API); built AWS infra from scratch with Terraform; distributed task processing with Celery + RabbitMQ; user-facing product in React Router v7 / Remix v8 with isomorphic rendering and real-time dashboards; engineering + managerial leadership (hiring, mentoring, code review, process); CI/CD, feature flags, analytics (Hotjar, Sentry), security-first practices.
  - **Studylog Systems** — Director of Engineering (Aug 2021 – Jul 2024). Director of all web/cloud activity — recruiting, mentoring, and leading a full-stack team plus daily IC work, code review, deployment. Node.js + React; performant, accessible, pixel-perfect experiences; technical training that drove a **>50% decrease in coding errors** in one year; QA + code-review processes; agile adoption; cloud infra with **Terraform, Helm, Kubernetes on AWS**. (Maps to the "first SOC 2" / cloud-native rewrite of the flagship Windows product.)
  - **Synack** — Senior Software Engineer II (Apr 2016 – Mar 2021). Lead engineer rebuilding key product verticals for quality, maintainability, and reduced tech debt. Revamped top-vertical UIs, **increasing user engagement >60% in under a year**; new user-focused workflows; internal coding standards/style guides that lifted team productivity and code quality.
  - **Ultimatum, Inc.** — Founder / CTO (Sep 2015 – Jul 2019). Founder and chief engineer; single-handedly built all interfaces, services, and dataflow. Crowd-fundraising web/mobile platform for automated donations to 501(c)(3)s based on real-world events; real-time ETL ingesting arbitrary third-party events; full SDLC with CI, **Docker + Kubernetes on GCP**.
  - **Lookout** — Senior Software Engineer, Team Lead (Apr 2013 – Apr 2016). Lead frontend engineer building workflows/tools for the security-research team discovering and analyzing Android malware; custom tooling that drove a **100% productivity increase** in under a year. (OraculumJS & FactoryJS open-source frameworks authored in this period.)
  - **PBworks** — Software Engineer (Oct 2011 – Mar 2013). Generalist building features/interfaces for cloud document & file management; performance work, cross-browser/device test routines.
  - **Earlier (condensed line):** Plug.dj — Backbone.js Consultant (2012–2013); Arrowhead Electronic Healthcare — Software Engineer (2010–2011); Infrahealth — Sr. Software Developer (2009–2010); ATX Hackerspace — Founding Member / "Hackervangelist" (2009–2011).
  - **Skills** — JS/TS, React (incl. Remix / React Router v7), Redux, Node.js, Python; Celery/RabbitMQ; PostgreSQL; AWS + GCP; Docker, Kubernetes, Helm, Terraform (IaC); CI/CD, feature flags, observability (Sentry, Hotjar); security-first / secure-by-default; AI-augmented engineering.
- **Note on tense:** Delphos ended Mar 2026 — present everything in the past tense and frame Steve as actively seeking the next 0→1. Do **not** say "currently at Delphos" anywhere on the site.
- **Confidentiality:** all Delphos details above are already public on Steve's LinkedIn, so they are cleared for use.
- **PDF generation:** render the built `/resume` page to PDF via headless Chrome (chrome-devtools MCP), commit to `/assets/`. Single source of truth → web and PDF never drift. Add a "Download PDF" link on the page.

### G. Honesty pass (cross-cutting)
**Keep** (Steve's own LinkedIn-stated metrics, defensible in interview):
- Synack ">60% engagement," Lookout "100% / doubled productivity," Studylog ">50% fewer coding errors."

**Strip** (invented only in site copy, no provenance anywhere Steve vouches for):
- "40% cost reduction," "75% manual-work reduction," "10x response times," "3 months ahead of schedule," "serving nonprofits nationwide."

**Also remove:** anonymous testimonials ("Technology Executive, Enterprise Client," etc.) → replace with real named references. Soften Ultimatum to "built solo" without market-outcome claims (Steve abandoned it).

## Out of scope
- Visual redesign / theme overhaul (keep the existing Tailwind look; content + structure only).
- Blog post content changes (posts stay; "Writing" is just the relabeled blog).
- New domain/hosting changes.

## Success criteria
- No consulting service pages or "Schedule Consultation" CTAs remain.
- Homepage, About, and Work read as one coherent founding-engineer identity in Steve's voice.
- Every quantitative claim on the site is either real-and-defensible or removed.
- A `/resume` page exists with a matching downloadable PDF.
- Nav reflects Home · About · Work · Writing · Résumé · Contact.
- Site builds cleanly (`build.sh` / Jekyll) with no broken internal links to deleted pages.

## Open items for Steve to confirm
1. ~~Titles and dates~~ — **resolved** (full LinkedIn history provided).
2. ~~Metrics to keep~~ — **resolved** (keep LinkedIn-backed, strip site-invented).
3. ~~Delphos confidentiality~~ — **resolved** (details already public on LinkedIn).
4. Which **testimonials** to feature — spec proposes a set; final pick is yours (low-stakes, can finalize during implementation).
