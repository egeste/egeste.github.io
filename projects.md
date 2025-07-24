---
layout: default
title: Projects - Steve Regester
description: Engineering portfolio showcasing transformative platforms, startup ventures, and enterprise solutions spanning 15+ years of technical leadership and innovation.
---

<!-- Hero Section -->
<section class="fullwidth-section hero-section">
  <div class="section-container">
    <header class="hero" role="banner">
      <h1 class="hero-name">Engineering Portfolio</h1>
      <p class="hero-subtitle">A comprehensive showcase of transformative platforms, startup ventures, and enterprise solutions spanning 15+ years of engineering leadership.</p>
    </header>
  </div>
</section>

<!-- Projects Section -->
<section class="fullwidth-section projects-section">
  <div class="section-container">
    <div class="card-grid" role="list" aria-label="Engineering projects portfolio">
      {% for project in site.data.projects %}
      <article class="card project-card" role="listitem">
        {% if project.image %}
        <div class="card-image">
          <img src="{{ project.image | relative_url }}" alt="Screenshot of {{ project.name }} project showing {{ project.description | truncate: 50 }}" loading="lazy">
        </div>
        {% endif %}
        <div class="card-content">
          <h3 class="card-title">{{ project.name }}</h3>
          <p class="card-description">{{ project.description }}</p>
          <a href="{{ project.link }}" class="card-link" target="_blank" rel="noopener noreferrer" aria-label="View {{ project.name }} project (opens in new tab)">View Project</a>
        </div>
      </article>
      {% endfor %}
    </div>
  </div>
</section>