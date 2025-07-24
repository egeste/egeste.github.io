---
layout: default
title: Blog - Steve Regester
description: Software engineering blog featuring insights on technology, security, team leadership, and building meaningful digital experiences.
---

{% include hero-section.html title="Engineering Blog" subtitle="Insights on technology, security, team leadership, and building meaningful digital experiences." %}

{% capture blog_posts_content %}
{% if site.posts.size > 0 %}
<div class="blog-posts-grid" role="list" aria-label="Blog posts">
  {% for post in site.posts %}
  <article class="blog-post-card card" role="listitem">
    <div class="card-content">
      <div class="post-meta">{{ post.date | date: "%B %d, %Y" }}</div>
      <h2 class="card-title">
        <a href="{{ post.url | relative_url }}" aria-label="Read {{ post.title }}">{{ post.title }}</a>
      </h2>
      <div class="card-description">
        {{ post.subtitle }}
      </div>
      <a href="{{ post.url | relative_url }}" class="card-link" aria-label="Read full post: {{ post.title }}">Read More</a>
    </div>
  </article>
  {% endfor %}
</div>
{% else %}
<div class="text-center">
  <p class="section-subtitle">No posts yet. Check back soon!</p>
</div>
{% endif %}
{% endcapture %}

{% include content-section.html section_class="blog-section" content=blog_posts_content %}

