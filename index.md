---
layout: default
---

<div class="hero">
  <h1 class="hero-title">{{ site.title }}</h1>
  <p class="hero-subtitle">{{ site.description }}</p>
</div>

<section class="section">
  <h2 class="section-title">About Me</h2>
  <p class="section-subtitle">Visionary engineering leader with 15+ years architecting transformative SaaS platforms and mentoring high-performing teams. I've co-founded successful crowd-fundraising platforms serving nonprofits, achieved 60%+ user engagement increases, and doubled research productivity through innovative security tooling. Currently serving as Staff Software Engineer at Delphos Labs, I specialize in React, Node.js, cloud-native architectures (AWS/GCP), and building cultures of empathetic excellence.</p>

  <div style="margin-top: 2rem;">
    <h3 style="font-size: 1.25rem; font-weight: 600; margin-bottom: 1rem; color: var(--color-text);">Key Achievements</h3>
    <div class="achievement-grid" style="display: grid; gap: 1rem; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));">
      <div class="achievement-item" style="padding: 1rem; background: var(--color-surface); border-radius: 0.5rem; border: 1px solid var(--color-border);">
        <strong style="color: var(--color-primary);">📈 60%+ User Engagement</strong><br>
        <span style="color: var(--color-text-light); font-size: 0.9rem;">Redesigned interfaces achieving massive engagement increases within 12 months</span>
      </div>
      <div class="achievement-item" style="padding: 1rem; background: var(--color-surface); border-radius: 0.5rem; border: 1px solid var(--color-border);">
        <strong style="color: var(--color-primary);">🛡️ SOC 2 Certification</strong><br>
        <span style="color: var(--color-text-light); font-size: 0.9rem;">Led cloud-native platform architecture achieving first SOC 2 compliance</span>
      </div>
      <div class="achievement-item" style="padding: 1rem; background: var(--color-surface); border-radius: 0.5rem; border: 1px solid var(--color-border);">
        <strong style="color: var(--color-primary);">🔍 2x Security Productivity</strong><br>
        <span style="color: var(--color-text-light); font-size: 0.9rem;">Developed specialized research tooling doubling verified security findings</span>
      </div>
      <div class="achievement-item" style="padding: 1rem; background: var(--color-surface); border-radius: 0.5rem; border: 1px solid var(--color-border);">
        <strong style="color: var(--color-primary);">✨ 50% Error Reduction</strong><br>
        <span style="color: var(--color-text-light); font-size: 0.9rem;">Implemented comprehensive training programs dramatically improving code quality</span>
      </div>
      <div class="achievement-item" style="padding: 1rem; background: var(--color-surface); border-radius: 0.5rem; border: 1px solid var(--color-border);">
        <strong style="color: var(--color-primary);">🚀 20% Faster Delivery</strong><br>
        <span style="color: var(--color-text-light); font-size: 0.9rem;">Achieved significant timeline reductions through agile adoption and leadership</span>
      </div>
      <div class="achievement-item" style="padding: 1rem; background: var(--color-surface); border-radius: 0.5rem; border: 1px solid var(--color-border);">
        <strong style="color: var(--color-primary);">🏗️ Co-Founded Startup</strong><br>
        <span style="color: var(--color-text-light); font-size: 0.9rem;">Built crowd-fundraising platform from ground up serving nonprofits nationwide</span>
      </div>
    </div>
  </div>
</section>

<section class="section">
  <h2 class="section-title">Latest Projects</h2>
  <div class="card-grid">
    {% assign featured_projects = site.data.projects | slice: 0, 6 %}
    {% for project in featured_projects %}
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
  <div class="text-center" style="margin-top: 2rem;">
    <a href="{{ '/projects' | relative_url }}" class="btn">View All Projects</a>
  </div>
</section>

<section class="section">
  <h2 class="section-title">Core Technical Expertise</h2>
  <div class="skills-grid" style="display: grid; gap: 1.5rem; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); margin-bottom: 3rem;">
    <div class="skill-category" style="padding: 1.5rem; background: var(--color-surface); border-radius: 0.75rem; border: 1px solid var(--color-border);">
      <h3 style="color: var(--color-primary); font-size: 1.1rem; font-weight: 600; margin-bottom: 0.75rem;">
        <span style="margin-right: 0.5rem; font-size: 1.2rem;">⚡</span>Frontend Excellence
      </h3>
      <p style="color: var(--color-text-light); font-size: 0.9rem; line-height: 1.5;">React, TypeScript, Next.js, React Router v7/Remix v8, Redux, Progressive Web Apps</p>
    </div>
    <div class="skill-category" style="padding: 1.5rem; background: var(--color-surface); border-radius: 0.75rem; border: 1px solid var(--color-border);">
      <h3 style="color: var(--color-primary); font-size: 1.1rem; font-weight: 600; margin-bottom: 0.75rem;">
        <span style="margin-right: 0.5rem; font-size: 1.2rem;">🏗️</span>Backend Architecture
      </h3>
      <p style="color: var(--color-text-light); font-size: 0.9rem; line-height: 1.5;">Node.js, Express.js, GraphQL, RESTful APIs, Microservices, RabbitMQ, Apache Kafka</p>
    </div>
    <div class="skill-category" style="padding: 1.5rem; background: var(--color-surface); border-radius: 0.75rem; border: 1px solid var(--color-border);">
      <h3 style="color: var(--color-primary); font-size: 1.1rem; font-weight: 600; margin-bottom: 0.75rem;">
        <span style="margin-right: 0.5rem; font-size: 1.2rem;">☁️</span>Cloud & DevOps
      </h3>
      <p style="color: var(--color-text-light); font-size: 0.9rem; line-height: 1.5;">AWS, GCP, Terraform, Kubernetes, Docker, CI/CD, Infrastructure as Code</p>
    </div>
    <div class="skill-category" style="padding: 1.5rem; background: var(--color-surface); border-radius: 0.75rem; border: 1px solid var(--color-border);">
      <h3 style="color: var(--color-primary); font-size: 1.1rem; font-weight: 600; margin-bottom: 0.75rem;">
        <span style="margin-right: 0.5rem; font-size: 1.2rem;">🗄️</span>Data Systems
      </h3>
      <p style="color: var(--color-text-light); font-size: 0.9rem; line-height: 1.5;">PostgreSQL, MongoDB, Redis, Elasticsearch, ETL Pipelines, Apache NiFi</p>
    </div>
    <div class="skill-category" style="padding: 1.5rem; background: var(--color-surface); border-radius: 0.75rem; border: 1px solid var(--color-border);">
      <h3 style="color: var(--color-primary); font-size: 1.1rem; font-weight: 600; margin-bottom: 0.75rem;">
        <span style="margin-right: 0.5rem; font-size: 1.2rem;">🔐</span>Security & Compliance
      </h3>
      <p style="color: var(--color-text-light); font-size: 0.9rem; line-height: 1.5;">SOC 2 Certification, OWASP Top 10, OAuth2, JWT, Zero Trust Architecture</p>
    </div>
    <div class="skill-category" style="padding: 1.5rem; background: var(--color-surface); border-radius: 0.75rem; border: 1px solid var(--color-border);">
      <h3 style="color: var(--color-primary); font-size: 1.1rem; font-weight: 600; margin-bottom: 0.75rem;">
        <span style="margin-right: 0.5rem; font-size: 1.2rem;">👥</span>Leadership & Quality
      </h3>
      <p style="color: var(--color-text-light); font-size: 0.9rem; line-height: 1.5;">Team Building, Technical Mentorship, Agile Methodologies, Engineering Excellence</p>
    </div>
    <div class="skill-category" style="padding: 1.5rem; background: var(--color-surface); border-radius: 0.75rem; border: 1px solid var(--color-border);">
      <h3 style="color: var(--color-primary); font-size: 1.1rem; font-weight: 600; margin-bottom: 0.75rem;">
        <span style="margin-right: 0.5rem; font-size: 1.2rem;">🧪</span>Testing & Quality Assurance
      </h3>
      <p style="color: var(--color-text-light); font-size: 0.9rem; line-height: 1.5;">Jest, Enzyme, ESLint, Comprehensive Testing Frameworks, TDD/BDD, Quality Standards</p>
    </div>
    <div class="skill-category" style="padding: 1.5rem; background: var(--color-surface); border-radius: 0.75rem; border: 1px solid var(--color-border);">
      <h3 style="color: var(--color-primary); font-size: 1.1rem; font-weight: 600; margin-bottom: 0.75rem;">
        <span style="margin-right: 0.5rem; font-size: 1.2rem;">📊</span>Analytics & Monitoring
      </h3>
      <p style="color: var(--color-text-light); font-size: 0.9rem; line-height: 1.5;">Hotjar, Sentry, Datadog, ELK Stack, Prometheus, Grafana, Performance Monitoring</p>
    </div>
    <div class="skill-category" style="padding: 1.5rem; background: var(--color-surface); border-radius: 0.75rem; border: 1px solid var(--color-border);">
      <h3 style="color: var(--color-primary); font-size: 1.1rem; font-weight: 600; margin-bottom: 0.75rem;">
        <span style="margin-right: 0.5rem; font-size: 1.2rem;">🚀</span>Message Systems & ETL
      </h3>
      <p style="color: var(--color-text-light); font-size: 0.9rem; line-height: 1.5;">RabbitMQ, Apache Kafka, SQS, Redis Pub/Sub, Apache NiFi, ETL Pipelines</p>
    </div>
    <div class="skill-category" style="padding: 1.5rem; background: var(--color-surface); border-radius: 0.75rem; border: 1px solid var(--color-border);">
      <h3 style="color: var(--color-primary); font-size: 1.1rem; font-weight: 600; margin-bottom: 0.75rem;">
        <span style="margin-right: 0.5rem; font-size: 1.2rem;">🤖</span>AI & Machine Learning
      </h3>
      <p style="color: var(--color-text-light); font-size: 0.9rem; line-height: 1.5;">TensorFlow, API Integration, Data Pipeline Optimization, Binary Analysis, Security Research</p>
    </div>
    <div class="skill-category" style="padding: 1.5rem; background: var(--color-surface); border-radius: 0.75rem; border: 1px solid var(--color-border);">
      <h3 style="color: var(--color-primary); font-size: 1.1rem; font-weight: 600; margin-bottom: 0.75rem;">
        <span style="margin-right: 0.5rem; font-size: 1.2rem;">🛠️</span>Modern Web Technologies
      </h3>
      <p style="color: var(--color-text-light); font-size: 0.9rem; line-height: 1.5;">Progressive Web Apps, WebAssembly, Isomorphic Applications, Responsive Design, WebSockets</p>
    </div>
  </div>
</section>

<section class="section">
  <h2 class="section-title">Let's Connect</h2>
  <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; margin-bottom: 2rem;">
    <a href="mailto:resume@egeste.net" class="btn btn-primary-cta" style="text-decoration: none;">📧 Email Me</a>
    <a href="https://linkedin.com/in/egeste" class="btn btn-secondary" target="_blank" style="text-decoration: none;">💼 LinkedIn</a>
    <a href="https://github.com/egeste" class="btn btn-secondary" target="_blank" style="text-decoration: none;">🔧 GitHub</a>
  </div>
  <p style="text-align: center; color: var(--color-text-light); font-size: 0.95rem;">Available for Staff/Principal/Director level engineering roles focused on architectural excellence, team leadership, and transformative product development.</p>
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