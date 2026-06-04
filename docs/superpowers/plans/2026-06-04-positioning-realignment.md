# Positioning Realignment Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Realign the site from a consulting service-menu into a focused founding-engineer brand (Steve's real voice + real history), and add a `/resume` page with a generated PDF.

**Architecture:** Jekyll static site (kramdown + Tailwind via CDN classes). Changes are content + structure: rewrite `_config.yml` globals and the global `Person` schema, prune the nav, redirect-stub the deleted consulting pages, rebuild `index.md` / `about.md` / `projects.md`, add `resume.md`, then render that page to a committed PDF. No JS test framework exists, so verification = `bundle exec jekyll build` succeeding + `grep` assertions on built HTML + a visual smoke check.

**Tech Stack:** Jekyll, Liquid, kramdown, Tailwind utility classes, `jekyll-redirect-from`, `jekyll-seo-tag`, headless Chromium (for PDF).

---

## Conventions for every task

- **Build command** (run from repo root): `bundle exec jekyll build --trace 2>&1 | tail -20`
  Expected: ends with `done in X.XXX seconds` and no `Liquid Exception` / `Error:` lines.
- **Serve for visual checks:** `bundle exec jekyll serve --host 127.0.0.1 --port 4000` (background), site at `http://127.0.0.1:4000`.
- Commit after each task with the exact message given. Never bundle two tasks into one commit.
- "Built HTML" means files under `_site/` after a build.

---

## File Structure

| File | Responsibility | Action |
| --- | --- | --- |
| `_config.yml` | Site-wide title, bio, author, `professional` block, nav labels, EXIF copyright | Modify |
| `_layouts/default.html` | Global `Person` JSON-LD + conditional service schema | Modify |
| `_includes/service-structured-data.html` | Service/offer JSON-LD | Delete |
| `_includes/navigation.html` | Top nav | Modify (drop Services dropdown, add Résumé, relabel) |
| `startup-consulting.md`, `fullstack-engineering.md`, `n8n-consulting.md`, `penetration-testing.md`, `osint-solutions.md`, `faq.md` | Consulting service pages + FAQ | Replace with redirect stubs |
| `index.md` | Homepage | Rebuild |
| `about.md` | About | Rewrite |
| `projects.md` | Work/portfolio | Reframe |
| `_data/projects.yml` | Project card data | Strip invented metrics only |
| `resume.md` | NEW résumé page (+ print mode) | Create |
| `assets/steve-regester-resume.pdf` | Generated PDF | Create |

---

## Task 1: Rewrite global config (`_config.yml`)

**Files:**
- Modify: `_config.yml`

- [ ] **Step 1: Replace site identity block (lines ~9–14).** Change `title`, `tagline`, `description` to:

```yaml
title: Steve Regester — Founding Engineer & Technical Leader
tagline: 0→1 builder · technical craftsman · fifteen years of high-quality software in hard domains
description: >-
  Steve Regester is a founding/staff software engineer and technical leader with 15 years building
  high-quality software from the ground up — most recently as employee #1 at Delphos Labs (AI binary
  analysis). Deep full-stack craft, 0→1 product work, and a security-first mindset from a career at
  security and intelligence companies. Currently looking for the next thing to build.
```

- [ ] **Step 2: Replace `author.bio`, `author.job_title`, `author.skills` (lines ~28–52).**

```yaml
  bio: >-
    Founding/staff software engineer and technical leader. Fifteen years building high-quality
    software from zero to one — security, intelligence, pharma, fintech. Obsessed with craft,
    the right-sized solution, and the feel of the things I build.
  location: Portland, Oregon, United States
  avatar: /assets/images/steve-regester-headshot.png
  website: https://egeste.net

  # Social profiles
  twitter: egeste_
  linkedin: egeste
  github: egeste

  # Professional details
  job_title: Founding Engineer & Technical Leader
  company: Open to new roles
  skills:
    - 0→1 Product Engineering
    - Full-Stack Development (React, Node.js, Python)
    - Software Architecture
    - Engineering Leadership
    - Cloud Infrastructure (AWS, GCP, Terraform, Kubernetes)
    - Security-First Engineering
    - AI-Augmented Development
```

- [ ] **Step 3: Replace the entire `professional:` block (lines ~110–154)** with corrected, real history (Delphos in the past, accurate dates):

```yaml
professional:
  # Most recent position (Delphos ended Mar 2026 — NOT current)
  current_company: ""
  current_role: ""
  most_recent_company: "Delphos Labs"
  most_recent_role: "Founding / Staff Software Engineer"

  # Career Context
  status: "Open to founding- and early-engineer roles"
  experience_years: "15 years"
  location: "Portland, Oregon"

  # Job Preferences
  seeking_roles: ["Founding Engineer", "Staff Engineer", "Principal Engineer", "Director of Engineering"]
  work_locations: ["Portland, Oregon", "Remote"]
  company_types: ["Early-stage startups", "Growth-stage companies"]

  # Core Skills
  expert_technologies: ["React", "Remix / React Router v7", "Node.js", "TypeScript", "Python", "AWS", "Terraform", "Kubernetes", "Docker"]
  key_skills: ["0→1 Product Engineering", "Technical Leadership", "Team Mentorship", "SaaS Architecture", "Full-Stack Development", "Security-First Engineering"]

  # Key Achievements (only Steve's own, defensible claims)
  achievements:
    - "Employee #1 at Delphos Labs — built an AI binary-analysis product and company from 0 to 1"
    - ">60% increase in user engagement through UI/UX rebuilds at Synack"
    - "100% (2x) security-research productivity gain through internal tooling at Lookout"
    - ">50% reduction in coding errors via training/process at Studylog"
    - "Led the cloud-native rewrite of a flagship product and the team behind it"

  # Work History (real titles + dates)
  work_history:
    - company: "Delphos Labs"
      role: "Founding / Staff Software Engineer"
      period: "2024–2026"
    - company: "Studylog Systems"
      role: "Director of Engineering"
      period: "2021–2024"
    - company: "Synack"
      role: "Senior Software Engineer II"
      period: "2016–2021"
    - company: "Ultimatum, Inc."
      role: "Founder & CTO"
      period: "2015–2019"
    - company: "Lookout"
      role: "Senior Software Engineer, Team Lead"
      period: "2013–2016"
```

- [ ] **Step 4: Relabel nav + drop FAQ (lines ~171–177).** Replace the `navigation:` block with:

```yaml
navigation:
  home: "Home"
  about: "About"
  projects: "Work"
  blog: "Writing"
  resume: "Résumé"
  contact: "Contact"
```

- [ ] **Step 5: De-consult the EXIF copyright metadata (lines ~259–270).** In `exif_processing.metadata`, replace every occurrence of the string `Technology Consulting & Engineering Leadership` with `Steve Regester`, `Technology Consulting Asset` → `Portfolio Asset`, and rewrite `keywords`/`subject`/`description`/`credit` to drop "consulting":

```yaml
    creator: "Steve Regester"
    artist: "Steve Regester"
    copyright: "© 2026 Steve Regester"
    copyright_notice: "© 2026 Steve Regester"
    rights: "© 2026 Steve Regester"
    source: "https://egeste.net"
    credit: "egeste.net — Steve Regester"
    contact: "info@egeste.net"
    keywords: "Steve Regester, founding engineer, software engineer, Portland Oregon, full-stack, 0 to 1"
    subject: "Steve Regester — founding engineer and technical leader"
    title: "Steve Regester — Portfolio Asset"
    description: "Asset from Steve Regester's professional portfolio"
```

- [ ] **Step 6: Update `content_settings` (lines ~244–249).** Set `content_type: "professional-portfolio"` stays; change `last_update: "2026-06"`. Leave the rest.

- [ ] **Step 7: Build.** Run the build command. Expected: success, no Liquid errors.

- [ ] **Step 8: Verify footer/title updated.** Run: `grep -o "Steve Regester — Founding Engineer & Technical Leader" _site/index.html | head -1`
  Expected: prints the new title (the footer uses `site.title`).

- [ ] **Step 9: Commit.**

```bash
git add _config.yml
git commit -m "refactor: reposition site config from consulting to founding engineer"
```

---

## Task 2: Replace global structured data (`_layouts/default.html`) + delete service schema

**Files:**
- Modify: `_layouts/default.html:120-180`
- Delete: `_includes/service-structured-data.html`

- [ ] **Step 1: Replace the JSON-LD object (lines ~120–176).** Swap the `["Person","ProfessionalService"]` block (with `serviceType`, `areaServed`, `hasOfferCatalog`) for a clean Person schema:

```html
  {
    "@context": "https://schema.org",
    "@type": "Person",
    "name": "{{ site.author.name }}",
    "url": "{{ site.url }}",
    "email": "{{ site.site_config.contact_email }}",
    "jobTitle": "{{ site.author.job_title }}",
    "description": "{{ site.author.bio | strip_html | strip_newlines }}",
    "knowsAbout": {{ site.author.skills | jsonify }},
    "address": {
      "@type": "PostalAddress",
      "addressLocality": "{{ site.site_config.city }}",
      "addressRegion": "{{ site.site_config.state }}"
    },
    "sameAs": {{ site.social.links | jsonify }}
  }
```

- [ ] **Step 2: Remove the conditional service-schema include (lines ~177–180).** Delete:

```html
  {% if page.type == 'service' %}
    {% include service-structured-data.html %}
  {% endif %}
```

- [ ] **Step 3: Delete the include file.**

```bash
git rm _includes/service-structured-data.html
```

- [ ] **Step 4: Build.** Expected: success, no `Unknown tag` / missing-include errors.

- [ ] **Step 5: Verify no Service schema remains.** Run: `grep -ri "hasOfferCatalog\|ProfessionalService\|Technology Consulting Services" _site/ | wc -l`
  Expected: `0`.

- [ ] **Step 6: Commit.**

```bash
git add _layouts/default.html
git commit -m "refactor: replace ProfessionalService schema with clean Person schema"
```

---

## Task 3: Prune navigation (`_includes/navigation.html`)

**Files:**
- Modify: `_includes/navigation.html`

- [ ] **Step 1: Delete the Services dropdown block (lines ~15–26)** — the entire `<div class="nav-dropdown ...">...</div>`.

- [ ] **Step 2: Add a Résumé link and relabel.** The `projects` link already uses `{{ site.navigation.projects }}` (now "Work") and `blog` uses `{{ site.navigation.blog }}` (now "Writing"), so those auto-relabel. Replace the FAQ link line (the `href="{{ '/faq' | relative_url }}"` anchor, ~line 30) with a Résumé link:

```html
      <a href="{{ '/resume' | relative_url }}" class="text-white font-medium text-base transition-colors duration-300 py-3 border-b border-slate-700/50 hover:text-violet-400 md:border-b-0 md:py-0 md:text-xs md:flex-1 md:text-center {% if page.url contains 'resume' %}font-bold{% endif %}" {% if page.url contains 'resume' %}aria-current="page"{% endif %}>{{ site.navigation.resume }}</a>
```

- [ ] **Step 3: Remove the now-dead desktop-dropdown JS (lines ~94–109)** — the `const dropdown = document.querySelector('.nav-dropdown');` block through its closing `}`. Leave the hamburger/overlay JS intact.

- [ ] **Step 4: Build, then verify.** Run: `grep -c "nav-dropdown\|Services\|osint-solutions\|penetration-testing" _site/index.html`
  Expected: `0`. Then `grep -c "/resume" _site/index.html` → `≥1`.

- [ ] **Step 5: Commit.**

```bash
git add _includes/navigation.html
git commit -m "refactor: remove Services dropdown, add Résumé nav, relabel Work/Writing"
```

---

## Task 4: Redirect-stub the deleted consulting pages + FAQ

**Why stubs not `rm`:** `jekyll-redirect-from` is already enabled. Replacing each page's content with a `redirect_to: /` stub removes the consulting content while 301-ing old inbound links to the homepage — host-independent (works whether deployed to Netlify, Vercel, or GitHub Pages). `sitemap: false` keeps them out of the sitemap.

**Files:**
- Overwrite: `startup-consulting.md`, `fullstack-engineering.md`, `n8n-consulting.md`, `penetration-testing.md`, `osint-solutions.md`, `faq.md`

- [ ] **Step 1: Overwrite each of the six files** with this exact 4-line stub (identical content for all six):

```markdown
---
redirect_to: /
sitemap: false
---
```

- [ ] **Step 2: Build.** Expected: success. `jekyll-redirect-from` generates an HTML meta-refresh page for each.

- [ ] **Step 3: Verify each old URL redirects home.** Run:

```bash
for p in startup-consulting fullstack-engineering n8n-consulting penetration-testing osint-solutions faq; do
  echo -n "$p: "; grep -o 'http-equiv="refresh"[^>]*url=[^"]*"' "_site/$p.html" | head -1 || echo MISSING
done
```

Expected: each prints a refresh meta tag pointing at `/` (root). None MISSING.

- [ ] **Step 4: Verify no consulting service copy remains in built output.** Run: `grep -ril "Schedule Consultation\|OSINT Solutions\|Penetration Testing\|N8N\|Free Consultation" _site/ | grep -v assets`
  Expected: no `index.html`, `about/`, `projects/` matches (stub pages may legitimately match nothing since they're now redirects). If `index.html`/`about/index.html` appear, they're fixed in later tasks — note but continue.

- [ ] **Step 5: Commit.**

```bash
git add startup-consulting.md fullstack-engineering.md n8n-consulting.md penetration-testing.md osint-solutions.md faq.md
git commit -m "refactor: redirect consulting service pages and FAQ to home"
```

---

## Task 5: Rebuild the homepage (`index.md`)

**Files:**
- Modify: `index.md` (full rewrite of body + front matter)

- [ ] **Step 1: Replace the front matter (lines 1–11)** with role-focused SEO:

```yaml
---
layout: default
title: Steve Regester — Founding Engineer & Technical Leader
description: Founding/staff software engineer and technical leader. 15 years building high-quality software from 0 to 1 in security, intelligence, and regulated domains. Open to founding- and early-engineer roles.
keywords: founding engineer, staff software engineer, technical leader, 0 to 1, React, Node.js, Python, full-stack, Portland Oregon
sitemap:
  priority: 1.0
  changefreq: weekly
  lastmod: true
type: profile
---
```

- [ ] **Step 2: Replace the entire body** with the new sections below. Keep the existing Tailwind class vocabulary (glass cards, gradients) for visual consistency.

```html
<div class="text-slate-100">

<!-- Hero -->
<section class="w-full min-h-[70vh] md:min-h-[85vh] py-8 md:py-16 flex items-center">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    <header class="hero" role="banner">
      <div class="flex flex-col md:flex-row items-center gap-8 md:gap-12 text-center md:text-left">
        <div class="flex-1 order-2 md:order-1">
          <h1 class="text-3xl sm:text-4xl lg:text-5xl font-bold text-white mb-6 tracking-tight leading-tight">Steve Regester</h1>
          <h2 class="text-xl sm:text-2xl lg:text-3xl font-semibold text-slate-100 mb-8 opacity-90">Founding engineer &amp; technical leader</h2>
          <p class="text-lg sm:text-xl text-slate-200 max-w-3xl leading-relaxed opacity-90">
            For fifteen years I've built software in hard domains — mobile security, intelligence, pharma, fintech — usually from nothing. Most recently I was employee #1 at <strong>Delphos Labs</strong>, taking an AI binary-analysis product from zero to one.
            <span class="block mt-4">I care less about titles than about building things that work, that last, and that respect the people who use them.</span>
            <span class="text-slate-200 font-medium italic opacity-80 mt-4 inline-block">I'm looking for the next thing to build from the ground up.</span>
          </p>
        </div>
        <div class="flex-shrink-0 order-1 md:order-2">
          <img src="{{ '/assets/images/steve-regester-headshot.png' | relative_url }}" alt="Steve Regester" class="w-48 h-72 sm:w-56 sm:h-84 lg:w-64 lg:h-96 object-cover rounded-2xl border-[3px] border-white/30 shadow-xl transition-all duration-300 hover:scale-105 hover:shadow-2xl hover:border-indigo-500/50">
        </div>
      </div>
    </header>
  </div>
</section>

<!-- What I actually do -->
<section class="w-full py-16 md:py-20 bg-white/95 backdrop-blur-lg border-t border-white/20 border-b border-white/10">
  <div class="w-full px-4 md:max-w-4xl md:mx-auto md:px-6">
    <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-900 mb-8 text-center relative after:content-[''] after:block after:w-24 after:h-1 after:bg-gradient-to-r after:from-blue-600 after:via-indigo-500 after:to-violet-500 after:mx-auto after:mt-6 after:rounded">What I actually do</h2>
    <div class="text-lg text-slate-600 max-w-3xl mx-auto leading-relaxed space-y-5">
      <p>I build products from zero to one, and I obsess over the parts most people skip: the feel of the thing, the right-sized solution, the defaults that make sense, the failure modes nobody wants to think about.</p>
      <p>I've spent most of my career at security and intelligence companies — Lookout, Synack, Delphos — so I build with a threat model in mind by default. But the through-line isn't security. It's craft. I'm the engineer teammates have described as <em>"the high-water mark for engineering talent"</em> and someone who <em>"keeps refining after most people would call it done."</em> I'd rather ship one thing that feels inevitable than ten that feel like work.</p>
      <p>And I lead. I've been a Director of Engineering, a CTO, and a team lead. I like building the team as much as the product — the kind of place where people feel safe enough to do their best work.</p>
    </div>
  </div>
</section>

<!-- What I've built -->
<section class="w-full py-16 md:py-20 bg-slate-50/90 backdrop-blur-md border-t border-white/30 border-b border-white/20">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-900 mb-8 text-center">What I've built</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8 mt-8 sm:mt-12" role="list">
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md" role="listitem">
        <strong class="text-slate-900 font-bold mb-3 block">Delphos Labs — AI binary analysis (0→1)</strong>
        <span class="text-slate-600 leading-relaxed block">Employee #1. Designed the platform, built the AWS infra from scratch with Terraform, the distributed pipeline (Celery + RabbitMQ), and the React/Remix product with real-time dashboards.</span>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md" role="listitem">
        <strong class="text-slate-900 font-bold mb-3 block">Studylog — cloud-native rewrite</strong>
        <span class="text-slate-600 leading-relaxed block">As Director of Engineering, led the rewrite of a flagship Windows product into a cloud-native web platform for pharma research — and built the team that shipped it.</span>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md" role="listitem">
        <strong class="text-slate-900 font-bold mb-3 block">Synack — security platform UIs</strong>
        <span class="text-slate-600 leading-relaxed block">Lead engineer rebuilding core product verticals for a crowdsourced pentesting platform. UI/UX rebuilds lifted user engagement &gt;60% in under a year.</span>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md" role="listitem">
        <strong class="text-slate-900 font-bold mb-3 block">Lookout — malware-research tooling</strong>
        <span class="text-slate-600 leading-relaxed block">Lead frontend engineer for the team hunting Android malware. Custom tooling doubled research productivity. Authored the open-source OraculumJS and FactoryJS frameworks.</span>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md" role="listitem">
        <strong class="text-slate-900 font-bold mb-3 block">Ultimatum — founder &amp; CTO</strong>
        <span class="text-slate-600 leading-relaxed block">Built an entire crowd-fundraising platform solo: real-time ETL ingesting world events to trigger automated donations to nonprofits. React, Docker, Kubernetes on GCP.</span>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md flex flex-col" role="listitem">
        <strong class="text-slate-900 font-bold mb-3 block">…and side projects</strong>
        <span class="text-slate-600 leading-relaxed block mb-6 flex-1">ClearBrief, MindMirror, OpenBathrooms, and more — the things I build for fun and to learn.</span>
        <a href="{{ '/projects' | relative_url }}" class="mt-auto inline-flex items-center justify-center gap-2 px-6 py-3 bg-slate-100 text-violet-700 rounded-xl font-semibold text-sm transition-all duration-300 hover:bg-violet-100 hover:shadow-md w-full">See all my work →</a>
      </div>
    </div>
  </div>
</section>

<!-- What people say -->
<section class="w-full py-16 md:py-20 bg-white/95 backdrop-blur-lg border-t border-white/20 border-b border-white/10">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-900 mb-8 text-center">What people I've worked with say</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 sm:gap-8 mt-8" role="list">
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md" role="listitem">
        <blockquote class="italic text-slate-700 m-0 py-2">"Steve still represents the high-water mark for me in terms of sheer front-end engineering talent… equally passionate about doing things the right way, at a high level of quality."</blockquote>
        <p class="font-bold text-violet-600 mt-4">— Derek Halliday, Chief Product Officer at Benchling</p>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md" role="listitem">
        <blockquote class="italic text-slate-700 m-0 py-2">"Steve's patience, clarity and thoughtfulness are exactly the qualities you'd look for in a staff full-stack engineer if not a CTO. Steve is a joy to work with."</blockquote>
        <p class="font-bold text-violet-600 mt-4">— Faye Salwin, Platform Engineer at Delphos Labs</p>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md" role="listitem">
        <blockquote class="italic text-slate-700 m-0 py-2">"Steve architected and developed a cloud-native platform… passing a rigorous third-party security audit and achieving the company's first SOC 2. He also recruited and mentored a talented team."</blockquote>
        <p class="font-bold text-violet-600 mt-4">— Brad Nemer, who managed Steve at Studylog</p>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md" role="listitem">
        <blockquote class="italic text-slate-700 m-0 py-2">"A brilliant engineer… he always pushed for the right solution first and knows how to juggle complex requirements and priorities."</blockquote>
        <p class="font-bold text-violet-600 mt-4">— Christophe Verbinnen, Principal Architect at KnowBe4</p>
      </div>
    </div>
  </div>
</section>

<!-- CTA -->
<section class="w-full py-16 md:py-20">
  <div class="w-full px-4 md:max-w-4xl md:mx-auto md:px-6 text-center">
    <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-50 mb-6">Let's build something</h2>
    <p class="text-lg text-slate-200 mb-10 max-w-2xl mx-auto">I'm looking for founding- and early-engineer roles — places where I can own real surface area and take something from zero to one. If that's you, I'd love to talk.</p>
    <div class="flex justify-center gap-4 flex-wrap flex-col sm:flex-row items-center">
      <a href="mailto:{{ site.social.email }}?subject=Let's%20talk" class="inline-flex items-center justify-center gap-2 px-6 sm:px-8 py-4 bg-gradient-to-r from-blue-600 via-indigo-500 to-violet-500 text-white rounded-xl font-semibold text-sm sm:text-base tracking-wide transition-all duration-300 shadow-md hover:from-blue-700 hover:via-indigo-600 hover:to-violet-600 hover:shadow-xl hover:-translate-y-0.5 min-h-[44px] w-full sm:w-auto max-w-[300px] sm:max-w-none">Email me</a>
      <a href="{{ '/resume' | relative_url }}" class="inline-flex items-center justify-center gap-2 px-6 sm:px-8 py-4 bg-white/90 backdrop-blur text-slate-900 border border-slate-300 rounded-xl font-semibold text-sm sm:text-base tracking-wide transition-all duration-300 shadow-sm hover:bg-slate-900 hover:text-white hover:border-slate-900 hover:shadow-md hover:-translate-y-0.5 min-h-[44px] w-full sm:w-auto max-w-[300px] sm:max-w-none">Read my résumé</a>
    </div>
  </div>
</section>

</div>
```

- [ ] **Step 3: Build.** Expected: success.

- [ ] **Step 4: Verify the rebuild.** Run: `grep -c "Schedule Consultation\|Transform Your Business\|Proven Results\|OSINT" _site/index.html`
  Expected: `0`. Then `grep -c "looking for the next thing\|founding- and early-engineer" _site/index.html` → `≥1`.

- [ ] **Step 5: Commit.**

```bash
git add index.md
git commit -m "feat: rebuild homepage around founding-engineer positioning"
```

---

## Task 6: Rewrite About (`about.md`)

**Files:**
- Modify: `about.md` (front matter + body)

- [ ] **Step 1: Replace the front matter (lines 1–47)** with:

```yaml
---
layout: service
title: About Steve Regester — Founding Engineer & Technical Leader
description: Steve Regester is a founding/staff software engineer and technical leader. Fifteen years building high-quality software from 0 to 1 across security, intelligence, pharma, and fintech.
keywords: Steve Regester, founding engineer, technical leader, software architect, Portland Oregon, React, Node.js, Python
sitemap:
  priority: 0.9
  changefreq: weekly
  lastmod: true
type: profile

hero:
  title: "Steve Regester"
  subtitle: "Founding engineer & technical leader"
  description: "Fifteen years building high-quality software from zero to one<br>Security, intelligence, pharma, fintech — usually from nothing"
  location: "Portland, Oregon • Open to founding- and early-engineer roles, remote or local"

value_prop:
  title: "The short version"
  subtitle: "I'm a builder first. I take products from zero to one and care about the parts most people skip — the feel of the thing, the right-sized solution, the failure modes nobody wants to think about.<br><br>Most of my career has been at security and intelligence companies — <strong>Lookout, Synack, Delphos</strong> — so I build with a threat model in mind by default. Most recently I was <strong>employee #1 at Delphos Labs</strong>, taking an AI binary-analysis product and company from nothing to a working SaaS.<br><br>I've also led: Director of Engineering, CTO, team lead. I like building the team as much as the product."

services:
  title: "What I'm good at"
  items:
    - title: "🚀 0→1 product engineering"
      description: "Taking things from nothing to working product. Architecture, infra, and the first version of everything — under real uncertainty, with judgment about what to build and what to skip."
    - title: "🛠️ Full-stack craft"
      description: "React (incl. Remix / React Router v7), Node.js, Python, PostgreSQL. End-to-end ownership with taste — right-sized solutions and software that feels good to use."
    - title: "☁️ Cloud & infrastructure"
      description: "AWS and GCP from scratch with Terraform, Kubernetes, Helm, Docker. Distributed processing (Celery, RabbitMQ), CI/CD, feature flags, observability."
    - title: "🔒 Security-first engineering"
      description: "A career at security/intelligence companies means secure-by-default is a habit, not an afterthought. Led the work behind a company's first SOC 2."
    - title: "👥 Engineering leadership"
      description: "Director of Engineering and CTO experience. Hiring, mentoring, code review, and the kind of culture where people feel safe enough to do their best work."
    - title: "🤖 AI-augmented development"
      description: "Building with and around modern AI — most recently automating binary reverse engineering. I think in specifications, not just syntax."

cta:
  title: "Let's build something"
  description: "I'm looking for founding- and early-engineer roles where I can own real surface area and take something from zero to one. If that's you, let's talk."
  subject: "Let's talk"
  primary_button: "Email me"
  secondary_button: "Read my résumé"
  info:
    highlight: "Open to founding/early-engineer roles • Remote or Portland, OR"
    tagline: ""
---
```

- [ ] **Step 2: Replace the body** (everything after the front matter) with a profile section + REAL named testimonials + how-I-work, dropping the anonymous testimonials and invented stats:

```html
<!-- Profile -->
<section class="w-full py-16 md:py-20 bg-white/95 backdrop-blur-lg border-t border-white/20">
  <div class="w-full px-4 md:max-w-4xl md:mx-auto md:px-6">
    <div class="flex flex-col md:flex-row items-center gap-8 md:gap-12">
      <div class="flex-shrink-0">
        <img src="{{ '/assets/images/steve-regester-headshot.png' | relative_url }}" alt="Steve Regester" class="w-48 h-48 md:w-56 md:h-56 object-cover rounded-2xl border-[3px] border-slate-200 shadow-lg">
      </div>
      <div class="flex-1 text-center md:text-left space-y-4">
        <p class="text-slate-600 leading-relaxed">I started writing code because it was the closest thing I'd found to magic — the ability to make an idea real. Fifteen years later, that's still the part I care about. I've spent that time building in domains where the details matter: mobile security at Lookout, crowdsourced pentesting at Synack, pharma research at Studylog, AI binary analysis at Delphos.</p>
        <p class="text-slate-600 leading-relaxed">The thing I keep coming back to is the <em>feel</em> of software — the difference between systems that flow and systems that grind. Good software respects momentum and the person on the other side of the screen. That belief shows up in everything I build, and it's the standard I hold teams to.</p>
      </div>
    </div>
  </div>
</section>

<!-- Testimonials (real, named) -->
<section class="w-full py-16 md:py-20 bg-slate-50/90 backdrop-blur-md border-t border-white/30">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-900 mb-8">What colleagues say</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8" role="list">
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md" role="listitem">
        <blockquote class="italic text-slate-700 m-0 py-2">"He goes above and beyond to break down complex concepts… while allowing you the autonomy to learn from your failures, creating a culture of intellectual vulnerability. Steve doesn't settle for mediocre code; he consistently delivers beautiful, clear, best-practice code."</blockquote>
        <p class="font-bold text-violet-600 mt-4">— Christina Wright, who reported to Steve at Studylog</p>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md" role="listitem">
        <blockquote class="italic text-slate-700 m-0 py-2">"I haven't before or since met anyone more passionate about engineering front-end applications in a structured way. His skills were in very high demand and allowed us to build web-based tools for very complex analysis workflows."</blockquote>
        <p class="font-bold text-violet-600 mt-4">— Mikko Tervahauta, Staff Engineer at Oura (led Steve at Lookout)</p>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md" role="listitem">
        <blockquote class="italic text-slate-700 m-0 py-2">"His ability to get a good overview of large and complex systems and design and implement elegant solutions for them is very impressive. He always pushed for the right solution first."</blockquote>
        <p class="font-bold text-violet-600 mt-4">— Christophe Verbinnen, Principal Architect at KnowBe4</p>
      </div>
    </div>
    <p class="text-slate-500 text-sm mt-6 italic">More references available on <a href="https://linkedin.com/in/egeste" class="text-violet-600 hover:text-violet-700">LinkedIn</a>.</p>
  </div>
</section>
```

- [ ] **Step 3: Build.** Expected: success.

- [ ] **Step 4: Verify.** Run: `grep -c "Enterprise Client\|60%+ Growth Acceleration\|Schedule Consultation\|Built Different" _site/about/index.html`
  Expected: `0`. Then `grep -c "Christophe Verbinnen\|employee #1\|Open to founding" _site/about/index.html` → `≥1`.

- [ ] **Step 5: Commit.**

```bash
git add about.md
git commit -m "feat: rewrite About in real voice with named testimonials"
```

---

## Task 7: Reframe Work page (`projects.md`) + clean project data (`_data/projects.yml`)

**Files:**
- Modify: `projects.md`
- Modify: `_data/projects.yml`

- [ ] **Step 1: Replace `projects.md` front matter (lines 1–43)** with portfolio framing (no consulting case-study language):

```yaml
---
layout: service
title: Work — Steve Regester
description: Selected work from 15 years of building software — AI binary analysis, security platforms, malware-research tooling, a cloud-native pharma platform, and side projects.
keywords: Steve Regester portfolio, software projects, React, Node.js, open source, OraculumJS, FactoryJS
sitemap:
  priority: 0.8
  changefreq: monthly
  lastmod: true
type: portfolio

hero:
  title: "Work"
  subtitle: "Things I've built"
  description: "Fifteen years of building — at security and intelligence companies, as a founder, and for the fun of it<br>A selection of the work I'm proud of"
  location: ""

value_prop:
  title: "Selected work"
  subtitle: "From AI binary analysis to security platforms to side projects — here's a cross-section of what I've built and how I think about building."
---
```

- [ ] **Step 2: Replace the body** (the `<!-- Featured Projects -->` section through the end) with honest project cards that drop invented metrics and the consulting CTAs. The `_data/projects.yml` grid is rendered elsewhere via `content-grid`/`projects.yml`; here we keep a curated "career highlights" set:

```html
<!-- Career highlights -->
<section class="w-full py-16 md:py-20 bg-slate-50/90 backdrop-blur-md border-t border-white/30">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-900 mb-8">Career highlights</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8" role="list">

      <article class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md flex flex-col" role="listitem">
        <strong class="text-slate-900 font-bold mb-3 block">Delphos Labs — AI binary analysis</strong>
        <span class="text-slate-600 leading-relaxed block flex-1">Employee #1 at a VC-backed startup automating binary reverse engineering with AI. Designed the platform; built AWS infra from scratch with Terraform; distributed pipeline with Celery + RabbitMQ; React/Remix product with real-time dashboards. (2024–2026)</span>
      </article>

      <article class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md flex flex-col" role="listitem">
        <strong class="text-slate-900 font-bold mb-3 block">Studylog — cloud-native rewrite</strong>
        <span class="text-slate-600 leading-relaxed block flex-1">As Director of Engineering, led the rewrite of a flagship Windows product into a cloud-native web platform for pharmaceutical research, and built/mentored the team that shipped it. Node.js, React, Terraform, Kubernetes on AWS. (2021–2024)</span>
      </article>

      <article class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md flex flex-col" role="listitem">
        <strong class="text-slate-900 font-bold mb-3 block">Synack — security platform</strong>
        <span class="text-slate-600 leading-relaxed block flex-1">Lead engineer rebuilding core verticals of a crowdsourced pentesting platform with a focus on quality and reduced technical debt. UI/UX rebuilds increased user engagement &gt;60% in under a year. (2016–2021)</span>
      </article>

      <article class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md flex flex-col" role="listitem">
        <strong class="text-slate-900 font-bold mb-3 block">Lookout — malware-research tooling &amp; OSS</strong>
        <span class="text-slate-600 leading-relaxed block flex-1">Lead frontend engineer for the team discovering and analyzing Android malware. Custom tooling doubled research productivity. Authored the open-source OraculumJS (enterprise JS MVC) and FactoryJS (DI container) frameworks. (2013–2016)</span>
      </article>

      <article class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md flex flex-col" role="listitem">
        <strong class="text-slate-900 font-bold mb-3 block">Ultimatum — founder &amp; CTO</strong>
        <span class="text-slate-600 leading-relaxed block flex-1">Founded and single-handedly built a crowd-fundraising platform: real-time ETL ingesting world events to trigger automated donations to 501(c)(3) nonprofits. React, Docker, Kubernetes on GCP. (2015–2019)</span>
      </article>

      <article class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md flex flex-col" role="listitem">
        <strong class="text-slate-900 font-bold mb-3 block">Side projects</strong>
        <span class="text-slate-600 leading-relaxed block flex-1">ClearBrief (AI browser extension), MindMirror (speech/sentiment/NER), OpenBathrooms.org, React Audiovis, and assorted hardware hacks. The grid below has the rest.</span>
      </article>

    </div>
  </div>
</section>

<!-- Project grid from _data/projects.yml -->
<section class="w-full py-16 md:py-20 bg-white/95 backdrop-blur-lg border-t border-white/20">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-900 mb-8">More projects</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8" role="list">
      {% for project in site.data.projects %}
      <article class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl overflow-hidden shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:shadow-2xl flex flex-col" role="listitem">
        {% if project.image %}<img src="{{ project.image }}" alt="{{ project.name }}" class="w-full h-40 object-cover" loading="lazy">{% endif %}
        <div class="p-6 flex flex-col flex-1">
          <strong class="text-slate-900 font-bold mb-2 block">{{ project.name }}</strong>
          <span class="text-slate-600 text-sm leading-relaxed block flex-1">{{ project.description }}</span>
          {% if project.link %}<a href="{{ project.link }}" class="mt-4 inline-flex items-center gap-1 text-violet-600 hover:text-violet-700 font-semibold text-sm">View →</a>{% endif %}
        </div>
      </article>
      {% endfor %}
    </div>
  </div>
</section>
```

- [ ] **Step 3: Clean `_data/projects.yml`** — strip invented metrics from two entries (keep everything else as-is):
  - Synack ARS entry: change description ending `Led development of sophisticated UI/UX achieving 60%+ user engagement increase within 12 months.` → `Led development of the UI/UX for quantifying attack resistance through advanced threat modeling.`
  - Lookout entry: change `Custom toolchain built with Backbone.js doubled research productivity, enabling breakthrough mobile threat discoveries.` → `Custom Backbone.js toolchain that sped up malware triage and enabled new mobile-threat discoveries.`
  - Ultimatum entry: keep, but ensure no "nationwide" claim (current text has none — leave as-is).

- [ ] **Step 4: Build.** Expected: success.

- [ ] **Step 5: Verify.** Run: `grep -c "Start Your Project\|consulting\|View OSINT Solutions\|Security Services →\|Automation Services" _site/projects/index.html`
  Expected: `0`. Then `grep -c "Career highlights\|OraculumJS" _site/projects/index.html` → `≥1`.

- [ ] **Step 6: Commit.**

```bash
git add projects.md _data/projects.yml
git commit -m "feat: reframe Work page around real projects, strip invented metrics"
```

---

## Task 8: Create the résumé page (`resume.md`)

**Files:**
- Create: `resume.md`

- [ ] **Step 1: Create `resume.md`** with a self-contained, print-friendly layout. It uses `layout: default` and its own markup (not the `service` layout) so the print stylesheet can hide the site chrome. Full content:

```html
---
layout: default
title: Résumé — Steve Regester
description: Résumé of Steve Regester — founding/staff software engineer and technical leader. 15 years building high-quality software from 0 to 1.
keywords: Steve Regester resume, founding engineer, staff software engineer, director of engineering
type: profile
sitemap:
  priority: 0.7
  changefreq: monthly
---

<style>
@media print {
  header[role="banner"], footer, .no-print, #mesh-background, .nav-overlay { display: none !important; }
  body { background: #fff !important; }
  .resume-wrap { max-width: none !important; margin: 0 !important; padding: 0 !important; }
  .resume-card { box-shadow: none !important; border: none !important; background: #fff !important; backdrop-filter: none !important; break-inside: avoid; }
  a { color: #000 !important; text-decoration: none !important; }
  h1, h2, h3, p, li, span, strong { color: #000 !important; }
}
</style>

<div class="resume-wrap w-full px-4 md:max-w-4xl md:mx-auto md:px-6 py-12 md:py-16">

  <!-- Header -->
  <div class="resume-card bg-white/95 backdrop-blur-lg rounded-2xl p-6 sm:p-10 shadow-md text-slate-800">
    <div class="flex flex-col sm:flex-row sm:items-end sm:justify-between gap-4 border-b border-slate-200 pb-6 mb-6">
      <div>
        <h1 class="text-3xl sm:text-4xl font-bold text-slate-900">Steve Regester</h1>
        <p class="text-lg text-violet-700 font-semibold mt-1">Founding Engineer &amp; Technical Leader</p>
        <p class="text-slate-600 mt-1">Portland, Oregon · Remote-friendly</p>
      </div>
      <div class="text-sm text-slate-600 sm:text-right space-y-1">
        <p><a href="mailto:info@egeste.net" class="text-violet-700 hover:text-violet-800">info@egeste.net</a></p>
        <p><a href="https://egeste.net" class="text-violet-700 hover:text-violet-800">egeste.net</a></p>
        <p><a href="https://linkedin.com/in/egeste" class="text-violet-700 hover:text-violet-800">linkedin.com/in/egeste</a> · <a href="https://github.com/egeste" class="text-violet-700 hover:text-violet-800">github.com/egeste</a></p>
        <p class="no-print pt-2"><a href="{{ '/assets/steve-regester-resume.pdf' | relative_url }}" class="inline-flex items-center gap-2 px-4 py-2 bg-violet-600 text-white rounded-lg font-semibold hover:bg-violet-700">Download PDF</a></p>
      </div>
    </div>

    <!-- Summary -->
    <p class="text-slate-700 leading-relaxed mb-8">Founding/staff software engineer and technical leader with 15 years building high-quality software from zero to one — across mobile security, intelligence, pharma, and fintech. Deep full-stack craft (React, Node.js, Python), hands-on cloud and infrastructure, and a security-first mindset from a career at security and intelligence companies. Comfortable as both the engineer who builds the first version of everything and the leader who hires and mentors the team. Looking for the next thing to build from the ground up.</p>

    <!-- Experience -->
    <h2 class="text-xl font-bold text-slate-900 border-b border-slate-200 pb-2 mb-5">Experience</h2>

    <div class="mb-6">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Founding / Staff Software Engineer — Delphos Labs</h3>
        <span class="text-sm text-slate-500">Jul 2024 – Mar 2026 · Remote</span>
      </div>
      <p class="text-slate-600 text-sm italic mb-2">Employee #1 at a VC-backed cybersecurity startup using AI to automate binary reverse engineering. Built the core product and company from 0 to 1.</p>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Designed the high-level platform architecture — SaaS product, automation pipelines, database, and API layer.</li>
        <li>Built cloud infrastructure from scratch with Terraform on AWS.</li>
        <li>Engineered distributed task processing with Celery and RabbitMQ for reliable workload distribution.</li>
        <li>Developed the user-facing product in React Router v7 / Remix with isomorphic rendering and real-time dashboards.</li>
        <li>Provided engineering and managerial leadership — hiring, mentoring, code review, and process design.</li>
        <li>Established CI/CD, feature flags, analytics (Sentry, Hotjar), and security-first development practices.</li>
      </ul>
    </div>

    <div class="mb-6">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Director of Engineering — Studylog Systems</h3>
        <span class="text-sm text-slate-500">Aug 2021 – Jul 2024</span>
      </div>
      <p class="text-slate-600 text-sm italic mb-2">Director of all web and cloud activity — recruiting, mentoring, and leading a full-stack team while contributing daily to code, review, and deployment.</p>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Led the cloud-native rewrite of a flagship Windows product into a performant, accessible web platform (Node.js, React) for pharmaceutical-research customers.</li>
        <li>Drove a &gt;50% reduction in coding errors in one year through technical training, QA processes, and routine code review.</li>
        <li>Built and maintained cloud infrastructure with Terraform, Helm, and Kubernetes on AWS.</li>
        <li>Led adoption of agile practices, reducing project delays and improving team morale; recruited and mentored the team.</li>
      </ul>
    </div>

    <div class="mb-6">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Senior Software Engineer II — Synack</h3>
        <span class="text-sm text-slate-500">Apr 2016 – Mar 2021</span>
      </div>
      <p class="text-slate-600 text-sm italic mb-2">Lead engineer rebuilding key product verticals of a crowdsourced security-testing platform, with a focus on quality, maintainability, and reduced technical debt.</p>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Revamped the UI for top product verticals, increasing user engagement &gt;60% in under a year.</li>
        <li>Led development of new, user-focused workflows and interfaces.</li>
        <li>Established internal coding standards and style guides that lifted team productivity and code quality.</li>
      </ul>
    </div>

    <div class="mb-6">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Founder &amp; CTO — Ultimatum, Inc.</h3>
        <span class="text-sm text-slate-500">Sep 2015 – Jul 2019</span>
      </div>
      <p class="text-slate-600 text-sm italic mb-2">Founder and chief engineer. Single-handedly built all interfaces, services, and dataflow for the platform.</p>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Built a crowd-fundraising web/mobile platform for automated donations to 501(c)(3) nonprofits triggered by real-world events.</li>
        <li>Implemented real-time ETL systems consuming arbitrary third-party events.</li>
        <li>Ran the full SDLC with CI, Docker, and Kubernetes on GCP.</li>
      </ul>
    </div>

    <div class="mb-6">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Senior Software Engineer, Team Lead — Lookout</h3>
        <span class="text-sm text-slate-500">Apr 2013 – Apr 2016</span>
      </div>
      <p class="text-slate-600 text-sm italic mb-2">Lead frontend engineer building workflows and tools for the team discovering and analyzing Android malware.</p>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Designed and built custom research tooling that doubled (100%+) the security-research team's productivity in under a year.</li>
        <li>Authored the open-source OraculumJS (enterprise JS MVC) and FactoryJS (DI container) frameworks.</li>
        <li>Partnered with researchers and engineers to design systems and select appropriate solutions.</li>
      </ul>
    </div>

    <div class="mb-8">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Software Engineer — PBworks</h3>
        <span class="text-sm text-slate-500">Oct 2011 – Mar 2013</span>
      </div>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Generalist building features and interfaces for cloud document and file management; performance work and cross-browser/device test routines.</li>
      </ul>
      <p class="text-slate-500 text-sm mt-2"><strong>Earlier:</strong> Backbone.js consultant at Plug.dj (2012–2013); Software Engineer at Arrowhead Electronic Healthcare (2010–2011); Sr. Software Developer at Infrahealth (2009–2010); founding member of ATX Hackerspace (2009–2011).</p>
    </div>

    <!-- Skills -->
    <h2 class="text-xl font-bold text-slate-900 border-b border-slate-200 pb-2 mb-4">Skills</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-x-8 gap-y-2 text-sm text-slate-700 mb-8">
      <p><strong>Languages:</strong> JavaScript/TypeScript, Python</p>
      <p><strong>Frontend:</strong> React, Remix / React Router v7, Redux</p>
      <p><strong>Backend:</strong> Node.js, REST/GraphQL APIs, PostgreSQL, Celery, RabbitMQ</p>
      <p><strong>Infrastructure:</strong> AWS, GCP, Terraform, Kubernetes, Helm, Docker</p>
      <p><strong>Practices:</strong> CI/CD, feature flags, observability (Sentry), security-first</p>
      <p><strong>Leadership:</strong> hiring, mentoring, code review, 0→1 product strategy</p>
    </div>

    <!-- Selected open source -->
    <h2 class="text-xl font-bold text-slate-900 border-b border-slate-200 pb-2 mb-4">Selected open source</h2>
    <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
      <li><strong>OraculumJS</strong> — enterprise JavaScript MVC framework (application framework + behavior library).</li>
      <li><strong>FactoryJS</strong> — dependency-injection container with object-level AOP hooks and memory debugging.</li>
    </ul>
  </div>
</div>
```

- [ ] **Step 2: Build.** Expected: success; `_site/resume/index.html` exists.

- [ ] **Step 3: Verify.** Run: `grep -c "Founding / Staff Software Engineer — Delphos Labs\|Director of Engineering — Studylog" _site/resume/index.html`
  Expected: `≥1` (matches the headings). Then confirm the page is in nav: `grep -c "/resume" _site/about/index.html` → `≥1`.

- [ ] **Step 4: Commit.**

```bash
git add resume.md
git commit -m "feat: add résumé page with real history and print styles"
```

---

## Task 9: Generate and commit the résumé PDF

**Files:**
- Create: `assets/steve-regester-resume.pdf`

- [ ] **Step 1: Build and serve the site in the background.**

```bash
bundle exec jekyll build --trace
( bundle exec jekyll serve --host 127.0.0.1 --port 4000 --no-watch >/tmp/jekyll-serve.log 2>&1 & echo $! > /tmp/jekyll.pid )
sleep 4
curl -sS -o /dev/null -w "%{http_code}\n" http://127.0.0.1:4000/resume
```

Expected: `200`.

- [ ] **Step 2: Render the page to PDF with headless Chromium.** Try, in order, the first browser binary that exists (`google-chrome`, `chromium`, `chromium-browser`):

```bash
BROWSER=$(command -v google-chrome || command -v chromium || command -v chromium-browser)
echo "Using: $BROWSER"
"$BROWSER" --headless=new --disable-gpu --no-sandbox \
  --print-to-pdf=assets/steve-regester-resume.pdf \
  --no-pdf-header-footer \
  http://127.0.0.1:4000/resume
ls -la assets/steve-regester-resume.pdf
```

Expected: a PDF file of non-trivial size (>20 KB).

**Fallback if no Chromium binary exists:** stop the server, tell Steve the PDF must be generated manually (open `http://127.0.0.1:4000/resume` → browser Print → Save as PDF → save to `assets/steve-regester-resume.pdf`), and skip to Step 4 once he confirms the file is in place. Do not fabricate the file.

- [ ] **Step 3: Stop the background server.**

```bash
kill "$(cat /tmp/jekyll.pid)" 2>/dev/null; rm -f /tmp/jekyll.pid
```

- [ ] **Step 4: Verify the PDF is valid.** Run: `file assets/steve-regester-resume.pdf`
  Expected: `... PDF document ...`.

- [ ] **Step 5: Commit.**

```bash
git add assets/steve-regester-resume.pdf
git commit -m "feat: add generated résumé PDF"
```

---

## Task 10: Full-site verification + cleanup sweep

**Files:** none (verification only)

- [ ] **Step 1: Clean production build.** Run: `bundle exec jekyll build --trace 2>&1 | tail -5`
  Expected: `done in ...`, no warnings about missing includes or broken Liquid.

- [ ] **Step 2: Grep the whole built site for surviving consulting language.** Run:

```bash
grep -ril "Schedule Consultation\|Free Consultation\|Transform Your Business\|Technology Consulting\|hasOfferCatalog\|ProfessionalService" _site/ | grep -v "/assets/"
```

Expected: **no output**. (If any page matches, fix that page's source and rebuild.)

- [ ] **Step 3: Check for broken internal links to deleted pages.** Run:

```bash
grep -rl "href=\"/startup-consulting\|href=\"/fullstack-engineering\|href=\"/n8n-consulting\|href=\"/penetration-testing\|href=\"/osint-solutions\|href=\"/faq" _site/ | grep -v -e startup-consulting -e fullstack-engineering -e n8n-consulting -e penetration-testing -e osint-solutions -e faq
```

Expected: **no output** (no live page still links to the retired routes; the redirect stubs themselves are excluded).

- [ ] **Step 4: Confirm the nav is correct across pages.** Run: `grep -o ">Work<\|>Writing<\|>Résumé<\|>Services<\|>FAQ<" _site/about/index.html | sort -u`
  Expected: includes `>Work<`, `>Writing<`, `>Résumé<`; excludes `>Services<` and `>FAQ<`.

- [ ] **Step 5: Visual smoke test.** Serve (`bundle exec jekyll serve --host 127.0.0.1 --port 4000`) and load `/`, `/about`, `/projects`, `/resume`, plus one retired URL (e.g. `/osint-solutions`) to confirm it redirects home. Use the chrome-devtools MCP (`new_page` → `navigate_page` → `take_snapshot`/`take_screenshot`) or a manual browser. Confirm: hero reads the new positioning, no Services dropdown, résumé renders, retired URL redirects.

- [ ] **Step 6: Final commit (if Step 2/3 required any source fixes).**

```bash
git add -A
git commit -m "chore: final positioning-realignment verification fixes"
```

---

## Self-Review (completed during planning)

- **Spec coverage:** Deletions → Task 4; nav → Task 3; homepage → Task 5; About → Task 6; Work + projects.yml → Task 7; résumé page + PDF → Tasks 8–9; honesty pass → distributed across Tasks 1, 5, 6, 7 + swept in Task 10; global config/schema (beyond spec, discovered during planning) → Tasks 1–2. Delphos-tense fix → Tasks 1, 5, 6, 8. All spec sections map to a task.
- **Placeholder scan:** no TBD/TODO; every content step contains final copy.
- **Type/string consistency:** nav labels set in `_config.yml` (Task 1) match the include references (Task 3: `site.navigation.resume`); PDF path `assets/steve-regester-resume.pdf` is identical in Tasks 8 (link) and 9 (output); redirect stub identical across all six files (Task 4).

## Open item (non-blocking)
Final testimonial selection is Steve's call. The plan uses Halliday, Salwin, Nemer, Verbinnen (homepage) and Wright, Tervahauta, Verbinnen (about). Swappable during execution without structural change.
