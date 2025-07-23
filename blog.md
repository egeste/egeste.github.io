---
layout: default
title: Blog
---

<div class="hero">
  <h1 class="hero-title">Blog</h1>
  <p class="hero-subtitle">Thoughts on technology, security, and building meaningful digital experiences.</p>
</div>

<section class="section">
  {% if site.posts.size > 0 %}
  <div class="post-list">
    {% for post in site.posts %}
    <article class="post-item">
      <h2 class="post-title">
        <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      </h2>
      <div class="post-meta">{{ post.date | date: "%B %d, %Y" }}</div>
      <div class="post-excerpt">
        {{ post.excerpt | strip_html | truncatewords: 50 }}
      </div>
      <a href="{{ post.url | relative_url }}" class="card-link">Read More</a>
    </article>
    {% endfor %}
  </div>
  {% else %}
  <div class="text-center">
    <p class="section-subtitle">No posts yet. Check back soon!</p>
  </div>
  {% endif %}
</section>