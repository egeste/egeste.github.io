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
    <div class="card project-card">
      {% if project.image %}
      <div class="card-image">
        <img src="{{ project.image | relative_url }}" alt="{{ project.name }}" loading="lazy">
      </div>
      {% endif %}
      <div class="card-content">
        <h3 class="card-title">{{ project.name }}</h3>
        <p class="card-description">{{ project.description }}</p>
        <a href="{{ project.link }}" class="card-link" target="_blank">View Project</a>
      </div>
    </div>
    {% endfor %}
  </div>
</section>