---
layout: default
title: Projects
---

<div class="hero">
  <h1 class="hero-title">Projects</h1>
  <p class="hero-subtitle">A showcase of my work spanning various technologies and domains.</p>
</div>

<section class="section">
  <div class="card-grid">
    {% for project in site.data.projects %}
    <div class="card">
      {% if project.image %}
      <div style="margin-bottom: 1rem;">
        <img src="{{ project.image }}" alt="{{ project.name }}" style="width: 100%; height: 200px; object-fit: cover; border-radius: var(--border-radius);">
      </div>
      {% endif %}
      <h3 class="card-title">{{ project.name }}</h3>
      <p class="card-description">{{ project.description }}</p>
      <a href="{{ project.link }}" class="card-link" target="_blank">View Project</a>
    </div>
    {% endfor %}
  </div>
</section>