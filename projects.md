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

<!-- Career highlights -->
<section class="w-full py-16 md:py-20 bg-slate-50/90 backdrop-blur-md border-t border-white/30">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-900 mb-8">Career highlights</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8" role="list">

      <article class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md flex flex-col" role="listitem">
        <strong class="text-slate-900 font-bold mb-3 block">Delphos Labs — AI binary analysis</strong>
        <span class="text-slate-600 leading-relaxed block flex-1">Employee #1 at a VC- and In-Q-Tel-backed startup automating binary reverse engineering with AI. Designed the platform; built AWS infra from scratch with Terraform; distributed pipeline with Celery + RabbitMQ; React/Remix product with real-time dashboards. (2024–2026)</span>
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
        <strong class="text-slate-900 font-bold mb-3 block">Ultimatum — co-founder &amp; CTO</strong>
        <span class="text-slate-600 leading-relaxed block flex-1">Co-founded a crowd-fundraising platform and single-handedly built the whole stack: real-time event processing (Apache NiFi) triggering automated donations to 501(c)(3) nonprofits. React, Docker, Kubernetes on GCP. (2015–2019)</span>
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
