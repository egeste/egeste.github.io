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
<section class="fullwidth-section about-section">
  <div class="section-container">
    {% if site.posts.size > 0 %}
    <div class="achievement-grid" role="list" aria-label="Blog posts">
      {% for post in site.posts %}
      <article class="achievement-item" role="listitem">
        <strong>{{ post.title }}</strong>
        <span>
          <em>{{ post.date | date: "%B %d, %Y" }}</em><br>
          {{ post.description | default: post.excerpt | strip_html | truncatewords: 20 }}
        </span>
        <div style="margin-top: 1rem;">
          <a href="{{ post.url | relative_url }}" class="btn btn-secondary">Read →</a>
        </div>
      </article>
      {% endfor %}
    </div>
    {% else %}
    <div style="text-align: center; padding: 2rem;">
      <p style="color: #666; font-size: 1.1em;">No posts yet.</p>
    </div>
    {% endif %}
  </div>
</section>

