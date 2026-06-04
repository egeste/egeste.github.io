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
/* Print / PDF: render as a plain, single-column, ATS-parseable document.
   Screen view (the styled card) is unaffected — everything here is @media print. */
@media print {
  @page { margin: 0.5in; size: letter; }

  header[role="banner"], footer, .no-print, #mesh-background, .nav-overlay, .mesh-background { display: none !important; }
  html, body { background: #fff !important; }
  body { font-family: Arial, Helvetica, sans-serif !important; }

  .resume-wrap { max-width: none !important; margin: 0 !important; padding: 0 !important; }
  .resume-card {
    box-shadow: none !important; border: none !important; background: #fff !important;
    backdrop-filter: none !important; border-radius: 0 !important; padding: 0 !important;
    color: #000 !important; font-size: 10pt !important; line-height: 1.3 !important;
  }

  /* Linearize every multi-column block so the PDF text stream reads top-to-bottom
     in a single column — this is what makes it ATS-safe. */
  .resume-card .flex, .resume-card .grid { display: block !important; }
  .resume-card *, .resume-card a { color: #000 !important; text-align: left !important; text-decoration: none !important; }

  /* Compact, standard typographic scale to fit two pages. */
  .resume-card h1 { font-size: 17pt !important; margin: 0 0 1pt !important; }
  .resume-card h2 { font-size: 11.5pt !important; margin: 9pt 0 3pt !important; padding-bottom: 2pt !important; border-bottom: 1px solid #000 !important; }
  .resume-card h3 { font-size: 10.5pt !important; margin: 6pt 0 0 !important; }
  .resume-card p  { font-size: 9.5pt !important; margin: 1pt 0 !important; }
  .resume-card li { font-size: 9.5pt !important; margin: 0 0 1pt !important; }
  .resume-card ul { margin: 2pt 0 4pt 16pt !important; }

  /* Collapse the large Tailwind vertical gaps. */
  .resume-card .mb-8, .resume-card .mb-6, .resume-card .mb-5, .resume-card .pb-6, .resume-card .mb-4 { margin-bottom: 6pt !important; padding-bottom: 0 !important; }
  .resume-card .border-b { border-bottom: 1px solid #000 !important; }

  /* Keep each role intact across page breaks. */
  .resume-card h2, .resume-card > div { break-inside: avoid; }
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
