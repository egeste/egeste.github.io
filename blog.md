---
layout: service
title: Blog - Steve Regester
description: Software engineering blog featuring insights on technology, security, team leadership, and building meaningful digital experiences.

hero:
  title: "Engineering Blog"
  subtitle: "Technical Notes & Development Insights"
  description: "Articles on software engineering, architecture, security, and team leadership<br>Notes from building systems and leading development teams"
  location: "Occasional updates on interesting technical problems and solutions"

value_prop:
  title: "Recent Posts"
  subtitle: "Technical articles covering software development, system design, security practices, and engineering leadership. Most posts focus on practical problems and solutions from real-world development experience."
---

<!-- Blog Posts -->
<section class="w-full py-16 md:py-20 bg-white/95 backdrop-blur-lg border-t border-white/20">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    {% if site.posts.size > 0 %}
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8" role="list" aria-label="Blog posts">
      {% for post in site.posts %}
      <article class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40 flex flex-col" role="listitem">
        <strong class="text-slate-900 font-bold mb-4 block">{{ post.title }}</strong>
        <span class="text-slate-600 leading-relaxed block flex-1">
          <em class="text-slate-500">{{ post.date | date: "%B %d, %Y" }}</em><br>
          {{ post.description | default: post.excerpt | strip_html | truncatewords: 20 }}
        </span>
        <div class="mt-6">
          <a href="{{ post.url | relative_url }}" class="inline-flex items-center justify-center gap-2 px-6 py-3 bg-slate-100 text-violet-700 rounded-xl font-semibold text-sm transition-all duration-300 hover:bg-violet-100 hover:shadow-md w-full">Read →</a>
        </div>
      </article>
      {% endfor %}
    </div>
    {% else %}
    <div class="text-center p-8">
      <p class="text-slate-500 text-lg">No posts yet.</p>
    </div>
    {% endif %}
  </div>
</section>

