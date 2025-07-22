---
layout: default
---

<div class="hero">
  <h1 class="hero-title">{{ site.title }}</h1>
  <p class="hero-subtitle">{{ site.description }}</p>
</div>

<section class="section">
  <h2 class="section-title">About Me</h2>
  <p class="section-subtitle">Steve Regester is a lifetime hacker, innovator, and builder of things. He has over a decade working in cybersecurity, but now focuses on consumer projects, social good startups, and AI.</p>
</section>

<section class="section">
  <h2 class="section-title">Latest Projects</h2>
  <div class="card-grid">
    {% assign featured_projects = site.data.projects | slice: 0, 3 %}
    {% for project in featured_projects %}
    <div class="card">
      <h3 class="card-title">{{ project.name }}</h3>
      <p class="card-description">{{ project.description }}</p>
      <a href="{{ project.link }}" class="card-link" target="_blank">View Project</a>
    </div>
    {% endfor %}
  </div>
  <div class="text-center" style="margin-top: 2rem;">
    <a href="{{ '/projects' | relative_url }}" class="btn">View All Projects</a>
  </div>
</section>

<section class="section">
  <h2 class="section-title">Recent Posts</h2>
  {% if site.posts.size > 0 %}
  <div class="post-list">
    {% for post in site.posts limit:2 %}
    <article class="post-item">
      <h3 class="post-title">
        <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      </h3>
      <div class="post-meta">{{ post.date | date: "%B %d, %Y" }}</div>
      <div class="post-excerpt">
        {{ post.excerpt | strip_html | truncatewords: 30 }}
      </div>
      <a href="{{ post.url | relative_url }}" class="card-link">Read More</a>
    </article>
    {% endfor %}
  </div>
  <div class="text-center" style="margin-top: 2rem;">
    <a href="{{ '/blog' | relative_url }}" class="btn btn-secondary">View All Posts</a>
  </div>
  {% else %}
  <p class="section-subtitle">No posts yet. Check back soon!</p>
  {% endif %}
</section>