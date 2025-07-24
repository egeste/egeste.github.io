---
layout: default
title: Blog - Steve Regester
description: Software engineering blog featuring insights on technology, security, team leadership, and building meaningful digital experiences.
---

<!-- Hero Section -->
<section class="fullwidth-section hero-section">
  <div class="section-container">
    <header class="hero" role="banner">
      <h1 class="hero-name">Software Engineering Blog</h1>
      <p class="hero-subtitle">Insights on technology, security, team leadership, and building meaningful digital experiences.</p>
    </header>
  </div>
</section>

<!-- Blog Posts Section -->
<section class="fullwidth-section blog-section">
  <div class="section-container">
    {% if site.posts.size > 0 %}
    <div class="post-list" role="list" aria-label="Blog posts">
      {% for post in site.posts %}
      <article class="post-item" role="listitem">
        <h2 class="post-title">
          <a href="{{ post.url | relative_url }}" aria-label="Read {{ post.title }}">{{ post.title }}</a>
        </h2>
        <div class="post-meta">{{ post.date | date: "%B %d, %Y" }}</div>
        <div class="post-excerpt">
          {{ post.excerpt | strip_html | truncatewords: 50 }}
        </div>
        <a href="{{ post.url | relative_url }}" class="card-link" aria-label="Read full post: {{ post.title }}">Read More</a>
      </article>
      {% endfor %}
    </div>
    {% else %}
    <div class="text-center">
      <p class="section-subtitle">No posts yet. Check back soon!</p>
    </div>
    {% endif %}
  </div>
</section>