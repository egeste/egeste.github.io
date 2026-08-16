---
layout: default
title: Résumé - Steve Regester
description: Résumé of Steve Regester - staff software engineer building security platforms. 15 years shipping security products, from malware research tooling to AI-driven binary analysis.
keywords: Steve Regester resume, staff software engineer, security engineer, full-stack engineer, AI agents
type: profile
sitemap:
  priority: 0.7
  changefreq: monthly
---

<style>
/* Print / PDF: render as a plain, single-column, ATS-parseable document.
   Screen view (the styled card) is unaffected - everything here is @media print. */
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
     in a single column - this is what makes it ATS-safe. */
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
        <p class="text-lg text-violet-700 font-semibold mt-1">Staff Software Engineer - Security Platforms</p>
        <p class="text-slate-600 mt-1">Southwest Washington | Portland Metro Area | Remote-friendly</p>
      </div>
      <div class="text-sm text-slate-600 sm:text-right space-y-1">
        <p><a href="mailto:info@egeste.net" class="text-violet-700 hover:text-violet-800">info@egeste.net</a></p>
        <p><a href="https://egeste.net" class="text-violet-700 hover:text-violet-800">egeste.net</a></p>
        <p><a href="https://linkedin.com/in/egeste" class="text-violet-700 hover:text-violet-800">linkedin.com/in/egeste</a> | <a href="https://github.com/egeste" class="text-violet-700 hover:text-violet-800">github.com/egeste</a></p>
        <p class="no-print pt-2"><a href="{{ '/assets/steve-regester-resume.pdf' | relative_url }}" class="inline-flex items-center gap-2 px-4 py-2 bg-violet-600 text-white rounded-lg font-semibold hover:bg-violet-700">Download PDF</a></p>
      </div>
    </div>

    <!-- Summary -->
    <p class="text-slate-700 leading-relaxed mb-8">Staff-level full-stack engineer with 15 years shipping security products - malware research tooling at Lookout, the crowdsourced pentesting platform at Synack, and AI-driven binary analysis at Delphos Labs. Deep craft in React, Node.js, and Python, with hands-on ownership of the infrastructure underneath: AWS, Terraform, Kubernetes, and distributed pipelines. Recent work applies LLM agents to specialist expert workflows. Former Director of Engineering - I hire, mentor, and raise the bar in code review, and I do my best work as a senior IC on a strong team.</p>

    <!-- Experience -->
    <h2 class="text-xl font-bold text-slate-900 border-b border-slate-200 pb-2 mb-5">Experience</h2>

    <div class="mb-6">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Founding Engineer - DesignForge AI</h3>
        <span class="text-sm text-slate-500">May 2026 - Present</span>
      </div>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Building an Electron desktop application that drives Ansys HFSS electromagnetic simulation through an LLM agent interface, on the Anthropic API and Claude Agent SDK.</li>
      </ul>
    </div>

    <div class="mb-6">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Founding / Staff Software Engineer - Delphos Labs</h3>
        <span class="text-sm text-slate-500">Jul 2024 - Mar 2026</span>
      </div>
      <p class="text-slate-600 text-sm italic mb-2">First engineer at a VC- and In-Q-Tel-backed cybersecurity company using AI to automate binary reverse engineering.</p>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Designed the platform architecture - SaaS product, database, and API layer - and built the distributed pipeline (Celery, RabbitMQ) that runs reverse-engineering workloads reliably at scale.</li>
        <li>Developed the analyst-facing product in React Router v7 / Remix, including real-time dashboards for reviewing automated analysis results.</li>
        <li>Partnered with security researchers to turn manual reverse-engineering workflows into reviewable, automated artifacts.</li>
        <li>Built and operated AWS infrastructure from scratch with Terraform, plus CI/CD, feature flags, and observability (Sentry, Hotjar).</li>
        <li>Hired and mentored engineers, ran code review, and established security-first development practices.</li>
      </ul>
    </div>

    <div class="mb-6">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Software Engineer - Descript</h3>
        <span class="text-sm text-slate-500">Mar 2024 - Jul 2024</span>
      </div>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Monetization engineering for a widely used audio and video editing product - implemented in-app paywalls and subscription upgrade flows.</li>
      </ul>
    </div>

    <div class="mb-6">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Director of Engineering - Studylog Systems</h3>
        <span class="text-sm text-slate-500">Aug 2021 - Oct 2023</span>
      </div>
      <p class="text-slate-600 text-sm italic mb-2">Led all web and cloud engineering - recruiting, mentoring, and leading a full-stack team while contributing daily to code, review, and deployment.</p>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Led the cloud-native rewrite of a flagship Windows product into a performant, accessible web platform (Node.js, React) for pharmaceutical-research customers, on AWS infrastructure built with Terraform, Helm, and Kubernetes.</li>
        <li>Took the platform through a rigorous third-party security audit and the company's first SOC 2.</li>
        <li>Drove a &gt;50% reduction in coding errors in one year through technical training, QA process, and routine code review.</li>
        <li>Recruited and mentored the team; led adoption of agile practices, reducing project delays and improving morale.</li>
      </ul>
    </div>

    <div class="mb-6">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Senior Software Engineer II - Synack</h3>
        <span class="text-sm text-slate-500">Apr 2016 - Mar 2021</span>
      </div>
      <p class="text-slate-600 text-sm italic mb-2">Lead engineer rebuilding key product verticals of a crowdsourced security-testing platform, with a focus on quality, maintainability, and reduced technical debt.</p>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Rebuilt the interfaces for top product verticals, increasing user engagement &gt;60% in under a year.</li>
        <li>Led development of new workflows and interfaces used by enterprise customers and vetted security researchers.</li>
        <li>Established internal coding standards and style guides adopted across the engineering team.</li>
      </ul>
    </div>

    <div class="mb-6">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Co-Founder &amp; CTO - Ultimatum, Inc.</h3>
        <span class="text-sm text-slate-500">Sep 2015 - Jul 2019</span>
      </div>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Co-founded and built a crowd-fundraising platform triggering automated donations to 501(c)(3) nonprofits from real-world events - real-time event processing with Apache NiFi, deployed with Docker and Kubernetes on GCP.</li>
      </ul>
    </div>

    <div class="mb-6">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Senior Software Engineer, Team Lead - Lookout</h3>
        <span class="text-sm text-slate-500">Apr 2013 - Apr 2016</span>
      </div>
      <p class="text-slate-600 text-sm italic mb-2">Lead frontend engineer building workflows and tools for the team discovering and analyzing Android malware.</p>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Designed and built custom research tooling that doubled the security-research team's productivity in under a year.</li>
        <li>Partnered daily with malware researchers to turn analysis workflows into software they actually used.</li>
        <li>Authored the open-source OraculumJS (enterprise JS MVC) and FactoryJS (DI container) frameworks.</li>
      </ul>
    </div>

    <div class="mb-8">
      <div class="flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
        <h3 class="text-lg font-semibold text-slate-900">Software Engineer - PBworks</h3>
        <span class="text-sm text-slate-500">Oct 2011 - Mar 2013</span>
      </div>
      <ul class="list-disc list-outside ml-5 text-slate-700 space-y-1 text-sm">
        <li>Generalist building features and interfaces for cloud document management; performance and cross-browser test work.</li>
      </ul>
      <p class="text-slate-500 text-sm mt-2"><strong>Earlier:</strong> Backbone.js consultant at Plug.dj (2012-2013); Software Engineer at Arrowhead Electronic Healthcare (2010-2011); Sr. Software Developer at Infrahealth (2009-2010); founding member of ATX Hackerspace (2009-2011).</p>
    </div>

    <!-- Tools -->
    <h2 class="text-xl font-bold text-slate-900 border-b border-slate-200 pb-2 mb-4">Tools I've worked with</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-x-8 gap-y-2 text-sm text-slate-700 mb-8">
      <p><strong>Languages &amp; frameworks:</strong> JavaScript/TypeScript, Python, React, Remix / React Router v7, Redux, Node.js, Electron</p>
      <p><strong>Data &amp; infrastructure:</strong> PostgreSQL, Celery, RabbitMQ, AWS, GCP, Terraform, Kubernetes, Helm, Docker</p>
      <p><strong>AI:</strong> Anthropic API, Claude Agent SDK, LLM tool use and agent orchestration</p>
      <p><strong>Practices:</strong> CI/CD, feature flags, observability (Sentry), security-first development, hiring, mentoring, code review</p>
    </div>
  </div>
</div>
