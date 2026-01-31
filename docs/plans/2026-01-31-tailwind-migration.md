# Tailwind CSS Migration - Replace All Custom CSS

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Replace all custom SCSS/CSS with Tailwind CDN classes while preserving the site's visual design, mobile-first approach, and accessibility features.

**Architecture:** Add Tailwind CDN to the default layout, then systematically convert each component/template from custom classes to Tailwind utility classes. The only custom CSS allowed is minimal styling for the mesh background animation.

**Tech Stack:** Tailwind CSS v3 CDN, Jekyll, Liquid templates

---

## Files Overview

**Delete after migration:**
- `assets/css/style.scss` (~1,560 lines)
- `assets/css/professional-homepage.scss` (~835 lines)

**Modify:**
- `_layouts/default.html` - Add Tailwind CDN, remove custom CSS link
- `_layouts/service.html` - Convert to Tailwind classes
- `_layouts/post.html` - Convert to Tailwind classes
- `_includes/navigation.html` - Convert to Tailwind classes
- `_includes/footer.html` - Convert to Tailwind classes
- `_includes/page-hero.html` - Convert to Tailwind classes
- `_includes/content-grid.html` - Convert to Tailwind classes
- `_includes/contact-buttons.html` - Convert to Tailwind classes
- `_includes/mesh-background.html` - Add minimal CSS for positioning
- `_includes/accessibility-styles.html` - Convert to Tailwind (keep reduced-motion)
- `index.md` - Convert homepage to Tailwind classes
- `about.md` - Convert to Tailwind classes
- `blog.md` - Convert to Tailwind classes
- `faq.md` - Convert to Tailwind classes
- `projects.md` - Convert to Tailwind classes
- All service pages (5 total)

---

## Task 1: Add Tailwind CDN and Minimal Mesh CSS

**Files:**
- Modify: `_layouts/default.html:25-27`
- Modify: `_includes/mesh-background.html:1-5`
- Modify: `_includes/accessibility-styles.html` (entire file)

**Step 1: Update default.html to add Tailwind CDN**

Replace the stylesheet section in `_layouts/default.html`:

```html
  <!-- ===== STYLESHEETS ===== -->
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      darkMode: 'class',
      theme: {
        extend: {
          fontFamily: {
            sans: ['Inter', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'sans-serif'],
          },
        },
      },
    }
  </script>
  <link href="{{ site.fonts.stylesheet }}" rel="stylesheet">
  <style>
    /* Mesh background - only custom CSS allowed */
    .mesh-background {
      position: fixed;
      inset: 0;
      z-index: -1;
      pointer-events: none;
      opacity: 0.4;
    }
    #mesh-canvas { width: 100%; height: 100%; display: block; }

    /* Reduced motion */
    @media (prefers-reduced-motion: reduce) {
      *, *::before, *::after {
        animation-duration: 0.01ms !important;
        transition-duration: 0.01ms !important;
      }
      .mesh-background { display: none; }
    }
  </style>
```

**Step 2: Remove the accessibility-styles include call and old CSS link**

In `_layouts/default.html`, remove these lines:
- `<link rel="stylesheet" href="{{ '/assets/css/style.css' | relative_url }}">`
- `{% include accessibility-styles.html %}`

**Step 3: Verify the page still loads**

Run: `bundle exec jekyll serve`
Expected: Page loads with Tailwind available, mesh background works

**Step 4: Commit**

```bash
git add _layouts/default.html
git commit -m "$(cat <<'EOF'
feat: add Tailwind CDN and minimal mesh background CSS

Replace custom CSS loading with Tailwind CDN. Only custom CSS
is the mesh background positioning and reduced motion support.

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Task 2: Convert Navigation Component

**Files:**
- Modify: `_includes/navigation.html`

**Step 1: Replace navigation.html with Tailwind classes**

```html
<header class="sticky top-0 z-50 backdrop-blur-md bg-slate-900/30 border-b border-slate-700/20 w-full" role="banner">
  <nav class="w-full px-4 flex justify-between items-center h-16 relative md:max-w-6xl md:mx-auto md:px-6 md:justify-around" role="navigation" aria-label="Main navigation">
    <!-- Mobile hamburger button -->
    <button class="flex md:hidden flex-col justify-around items-center w-11 h-11 p-2 cursor-pointer z-[1001]" aria-label="Toggle navigation menu" aria-expanded="false" aria-controls="nav-menu">
      <span class="hamburger-line w-6 h-0.5 bg-white transition-all duration-300 origin-center"></span>
      <span class="hamburger-line w-6 h-0.5 bg-white transition-all duration-300 origin-center"></span>
      <span class="hamburger-line w-6 h-0.5 bg-white transition-all duration-300 origin-center"></span>
    </button>

    <!-- Navigation links -->
    <div class="nav-menu fixed top-0 -right-full w-[280px] max-w-[85vw] h-screen bg-slate-900 flex flex-col justify-start items-stretch pt-16 px-6 pb-6 gap-4 transition-all duration-300 z-[1000] overflow-y-auto border-l border-slate-700 md:static md:right-auto md:w-auto md:max-w-none md:h-auto md:bg-transparent md:flex-row md:justify-around md:items-center md:p-0 md:gap-4 md:border-l-0 md:overflow-visible" id="nav-menu">
      <a href="{{ '/' | relative_url }}" class="text-white font-medium text-base transition-colors duration-300 py-3 border-b border-slate-700/50 hover:text-violet-400 md:border-b-0 md:py-0 md:text-xs md:flex-1 md:text-center {% if page.url == '/' %}font-bold{% endif %}" {% if page.url == '/' %}aria-current="page"{% endif %}>{{ site.navigation.home }}</a>
      <a href="{{ '/about' | relative_url }}" class="text-white font-medium text-base transition-colors duration-300 py-3 border-b border-slate-700/50 hover:text-violet-400 md:border-b-0 md:py-0 md:text-xs md:flex-1 md:text-center {% if page.url contains 'about' %}font-bold{% endif %}" {% if page.url contains 'about' %}aria-current="page"{% endif %}>About</a>

      <div class="nav-dropdown w-full md:relative md:flex md:flex-1 md:w-auto">
        <a href="#" class="text-white font-medium text-base transition-colors duration-300 py-3 border-b border-slate-700/50 hover:text-violet-400 md:border-b-0 md:py-0 md:text-xs md:text-center md:w-full {% if page.url contains 'startup-consulting' or page.url contains 'fullstack-engineering' or page.url contains 'n8n-consulting' or page.url contains 'penetration-testing' or page.url contains 'osint-solutions' %}font-bold{% endif %}">
          Services <span class="hidden md:inline text-xs">▼</span>
        </a>
        <div class="dropdown-menu static opacity-100 visible transform-none bg-transparent border-none shadow-none p-0 ml-4 md:absolute md:top-[calc(100%+11px)] md:left-0 md:min-w-[160px] md:bg-slate-900/80 md:backdrop-blur-xl md:border md:border-slate-700/30 md:border-t-0 md:rounded-b-lg md:shadow-lg md:opacity-0 md:invisible md:-translate-y-1 md:transition-all md:duration-200 md:z-[1000] md:p-0 md:ml-0 group-hover:md:opacity-100 group-hover:md:visible group-hover:md:translate-y-0">
          <a href="{{ '/startup-consulting' | relative_url }}" class="block py-2 text-slate-300 no-underline font-medium transition-colors duration-200 border-b border-slate-700/50 text-sm hover:bg-violet-500/10 hover:text-violet-400 md:py-3 md:px-4 {% if page.url contains 'startup-consulting' %}text-violet-400 bg-violet-500/10{% endif %}">Startup Consulting</a>
          <a href="{{ '/fullstack-engineering' | relative_url }}" class="block py-2 text-slate-300 no-underline font-medium transition-colors duration-200 border-b border-slate-700/50 text-sm hover:bg-violet-500/10 hover:text-violet-400 md:py-3 md:px-4 {% if page.url contains 'fullstack-engineering' %}text-violet-400 bg-violet-500/10{% endif %}">Full-Stack Engineering</a>
          <a href="{{ '/n8n-consulting' | relative_url }}" class="block py-2 text-slate-300 no-underline font-medium transition-colors duration-200 border-b border-slate-700/50 text-sm hover:bg-violet-500/10 hover:text-violet-400 md:py-3 md:px-4 {% if page.url contains 'n8n-consulting' %}text-violet-400 bg-violet-500/10{% endif %}">Business Automation</a>
          <a href="{{ '/penetration-testing' | relative_url }}" class="block py-2 text-slate-300 no-underline font-medium transition-colors duration-200 border-b border-slate-700/50 text-sm hover:bg-violet-500/10 hover:text-violet-400 md:py-3 md:px-4 {% if page.url contains 'penetration-testing' %}text-violet-400 bg-violet-500/10{% endif %}">Security & Code Review</a>
          <a href="{{ '/osint-solutions' | relative_url }}" class="block py-2 text-slate-300 no-underline font-medium transition-colors duration-200 text-sm hover:bg-violet-500/10 hover:text-violet-400 md:py-3 md:px-4 {% if page.url contains 'osint-solutions' %}text-violet-400 bg-violet-500/10{% endif %}">OSINT Solutions</a>
        </div>
      </div>

      <a href="{{ '/projects' | relative_url }}" class="text-white font-medium text-base transition-colors duration-300 py-3 border-b border-slate-700/50 hover:text-violet-400 md:border-b-0 md:py-0 md:text-xs md:flex-1 md:text-center {% if page.url contains 'projects' %}font-bold{% endif %}" {% if page.url contains 'projects' %}aria-current="page"{% endif %}>{{ site.navigation.projects }}</a>
      <a href="{{ '/blog' | relative_url }}" class="text-white font-medium text-base transition-colors duration-300 py-3 border-b border-slate-700/50 hover:text-violet-400 md:border-b-0 md:py-0 md:text-xs md:flex-1 md:text-center {% if page.url contains 'blog' %}font-bold{% endif %}" {% if page.url contains 'blog' %}aria-current="page"{% endif %}>{{ site.navigation.blog }}</a>
      <a href="{{ '/faq' | relative_url }}" class="text-white font-medium text-base transition-colors duration-300 py-3 border-b border-slate-700/50 hover:text-violet-400 md:border-b-0 md:py-0 md:text-xs md:flex-1 md:text-center {% if page.url contains 'faq' %}font-bold{% endif %}" {% if page.url contains 'faq' %}aria-current="page"{% endif %}>{{ site.navigation.faq }}</a>
      <a href="mailto:{{ site.social.email }}" class="text-white font-medium text-base transition-colors duration-300 py-3 hover:text-violet-400 md:py-0 md:text-xs md:flex-1 md:text-center" aria-label="Contact {{ site.author.name }} via email">Contact</a>
    </div>
  </nav>

  <!-- Mobile navigation overlay -->
  <div class="nav-overlay hidden fixed top-0 left-0 w-screen h-screen bg-black/50 z-[999]"></div>
</header>

<script>
document.addEventListener('DOMContentLoaded', function() {
  const navToggle = document.querySelector('button[aria-controls="nav-menu"]');
  const navMenu = document.querySelector('.nav-menu');
  const navOverlay = document.querySelector('.nav-overlay');
  const body = document.body;
  const lines = navToggle.querySelectorAll('.hamburger-line');

  function toggleNav() {
    const isOpen = navToggle.getAttribute('aria-expanded') === 'true';

    navToggle.setAttribute('aria-expanded', !isOpen);
    if (!isOpen) {
      navMenu.classList.remove('-right-full');
      navMenu.classList.add('right-0');
      navOverlay.classList.remove('hidden');
      navOverlay.classList.add('block');
      body.classList.add('overflow-hidden');
      lines[0].classList.add('translate-y-[7px]', 'rotate-45');
      lines[1].classList.add('opacity-0');
      lines[2].classList.add('-translate-y-[7px]', '-rotate-45');
    } else {
      closeNav();
    }
  }

  function closeNav() {
    navToggle.setAttribute('aria-expanded', 'false');
    navMenu.classList.add('-right-full');
    navMenu.classList.remove('right-0');
    navOverlay.classList.add('hidden');
    navOverlay.classList.remove('block');
    body.classList.remove('overflow-hidden');
    lines[0].classList.remove('translate-y-[7px]', 'rotate-45');
    lines[1].classList.remove('opacity-0');
    lines[2].classList.remove('-translate-y-[7px]', '-rotate-45');
  }

  navToggle.addEventListener('click', toggleNav);
  navOverlay.addEventListener('click', closeNav);

  document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape' && navToggle.getAttribute('aria-expanded') === 'true') {
      closeNav();
    }
  });

  navMenu.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', function() {
      if (window.innerWidth < 768) {
        closeNav();
      }
    });
  });

  // Desktop dropdown hover
  const dropdown = document.querySelector('.nav-dropdown');
  if (dropdown) {
    dropdown.addEventListener('mouseenter', function() {
      if (window.innerWidth >= 768) {
        this.querySelector('.dropdown-menu').classList.add('md:opacity-100', 'md:visible', 'md:translate-y-0');
        this.querySelector('.dropdown-menu').classList.remove('md:opacity-0', 'md:invisible', 'md:-translate-y-1');
      }
    });
    dropdown.addEventListener('mouseleave', function() {
      if (window.innerWidth >= 768) {
        this.querySelector('.dropdown-menu').classList.remove('md:opacity-100', 'md:visible', 'md:translate-y-0');
        this.querySelector('.dropdown-menu').classList.add('md:opacity-0', 'md:invisible', 'md:-translate-y-1');
      }
    });
  }
});
</script>
```

**Step 2: Test navigation on mobile and desktop**

Run: `bundle exec jekyll serve`
Expected: Navigation works on all breakpoints, hamburger menu functions

**Step 3: Commit**

```bash
git add _includes/navigation.html
git commit -m "$(cat <<'EOF'
feat: convert navigation to Tailwind classes

Mobile-first responsive navigation with hamburger menu.
Desktop dropdown hover behavior preserved.

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Task 3: Convert Footer Component

**Files:**
- Modify: `_includes/footer.html`

**Step 1: Replace footer.html with Tailwind classes**

```html
<footer class="border-t border-white/20 backdrop-blur-md bg-slate-800/60 py-6 md:py-8 mt-auto w-full" role="contentinfo">
  <div class="w-full px-4 text-center text-slate-300 text-sm md:max-w-6xl md:mx-auto md:px-6">
    <p>&copy; {{ 'now' | date: '%Y' }} {{ site.title }}. All rights reserved.</p>
  </div>
</footer>
```

**Step 2: Verify footer appears correctly**

Run: `bundle exec jekyll serve`
Expected: Footer shows at bottom with correct styling

**Step 3: Commit**

```bash
git add _includes/footer.html
git commit -m "$(cat <<'EOF'
feat: convert footer to Tailwind classes

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Task 4: Convert Page Hero Component

**Files:**
- Modify: `_includes/page-hero.html`

**Step 1: Replace page-hero.html with Tailwind classes**

```html
<!-- Professional Hero Section Component -->
<section class="w-full py-12 md:py-20 min-h-[60vh] md:min-h-[70vh] flex items-center">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    <header class="text-center animate-fade-in" role="banner">
      <h1 class="text-3xl sm:text-4xl lg:text-5xl font-bold text-white mb-4 tracking-tight">{{ include.title | default: page.hero.title | default: page.title }}</h1>
      {% assign subtitle = include.subtitle | default: page.hero.subtitle %}
      {% if subtitle %}<h2 class="text-xl sm:text-2xl lg:text-3xl font-semibold text-slate-100 mb-6 opacity-90">{{ subtitle }}</h2>{% endif %}
      {% assign description = include.description | default: page.hero.description %}
      {% if description %}
        <p class="text-lg sm:text-xl text-slate-200 max-w-3xl mx-auto leading-relaxed opacity-90">
          {{ description }}
          {% assign location = include.location | default: page.hero.location %}
          {% if location %}<br><span class="text-slate-200 font-medium italic opacity-80 mt-2 inline-block">{{ location }}</span>{% endif %}
        </p>
      {% endif %}
      {% if include.date %}
      <p class="text-sm text-slate-300 opacity-80 mt-4">
        <time datetime="{{ include.date | date_to_xmlschema }}">{{ include.date | date: "%B %d, %Y" }}</time>
      </p>
      {% endif %}
    </header>
  </div>
</section>
```

**Step 2: Verify hero sections display correctly**

Run: `bundle exec jekyll serve`
Expected: Hero sections on all pages render properly

**Step 3: Commit**

```bash
git add _includes/page-hero.html
git commit -m "$(cat <<'EOF'
feat: convert page-hero to Tailwind classes

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Task 5: Convert Content Grid Component

**Files:**
- Modify: `_includes/content-grid.html`

**Step 1: Replace content-grid.html with Tailwind classes**

```html
<!-- Reusable Content Grid Component -->
{% assign section_bg = include.section_class | default: 'about-section' %}
{% if section_bg == 'about-section' or section_bg == 'skills-section' %}
  {% assign bg_classes = 'bg-white/95 backdrop-blur-lg border-t border-white/20 border-b border-white/10' %}
  {% assign title_color = 'text-slate-900' %}
  {% assign text_color = 'text-slate-600' %}
  {% assign card_title_color = 'text-slate-900' %}
{% elsif section_bg == 'achievements-section' %}
  {% assign bg_classes = 'bg-slate-50/90 backdrop-blur-md border-t border-white/30 border-b border-white/20' %}
  {% assign title_color = 'text-slate-900' %}
  {% assign text_color = 'text-slate-600' %}
  {% assign card_title_color = 'text-slate-900' %}
{% elsif section_bg == 'contact-section' %}
  {% assign bg_classes = 'bg-slate-900/90 backdrop-blur-xl border-t border-white/10' %}
  {% assign title_color = 'text-slate-50' %}
  {% assign text_color = 'text-slate-300' %}
  {% assign card_title_color = 'text-slate-100' %}
{% else %}
  {% assign bg_classes = 'bg-transparent' %}
  {% assign title_color = 'text-slate-100' %}
  {% assign text_color = 'text-slate-300' %}
  {% assign card_title_color = 'text-slate-100' %}
{% endif %}

<section class="w-full py-16 md:py-20 {{ bg_classes }}">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    {% if include.title %}
      <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold {{ title_color }} mb-8 pl-4 relative before:content-[''] before:absolute before:left-0 before:top-0 before:bottom-0 before:w-1 before:bg-gradient-to-b before:from-blue-500 before:to-violet-500 before:rounded">{{ include.title }}</h2>
    {% endif %}

    {% if include.subtitle %}
      <p class="text-lg {{ text_color }} mb-10 leading-relaxed">{{ include.subtitle }}</p>
    {% endif %}

    {% if include.items %}
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8 lg:gap-10 mt-8 sm:mt-12" role="list">
        {% for item in include.items %}
          <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
            <strong class="{{ card_title_color }} font-bold mb-4 block">{{ item.title }}</strong>
            <span class="{{ text_color }} leading-relaxed block">{{ item.description }}</span>
            {% if item.link %}
              <div class="mt-6">
                <a href="{{ item.link }}" class="inline-flex items-center justify-center gap-2 px-6 py-3 bg-slate-800 text-white rounded-xl font-semibold text-sm transition-all duration-300 hover:bg-gradient-to-r hover:from-emerald-500 hover:to-blue-500 hover:shadow-lg w-full">{{ item.link_text | default: 'Learn More →' }}</a>
              </div>
            {% endif %}
          </div>
        {% endfor %}
      </div>
    {% endif %}

    {% if include.content %}
      {{ include.content }}
    {% endif %}
  </div>
</section>
```

**Step 2: Verify content grids render correctly across pages**

Run: `bundle exec jekyll serve`
Expected: Grids display with proper backgrounds and responsive layouts

**Step 3: Commit**

```bash
git add _includes/content-grid.html
git commit -m "$(cat <<'EOF'
feat: convert content-grid to Tailwind classes

Responsive grid with theme-aware backgrounds.

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Task 6: Convert Contact Buttons Component

**Files:**
- Modify: `_includes/contact-buttons.html`

**Step 1: Replace contact-buttons.html with Tailwind classes**

```html
<!-- Contact Button Component -->
<div class="flex justify-center gap-4 flex-wrap my-12 flex-col sm:flex-row items-center">
  {% if include.primary_text and include.primary_link %}
    <a href="{{ include.primary_link }}"
       class="inline-flex items-center justify-center gap-2 px-6 sm:px-8 py-4 bg-gradient-to-r from-blue-600 via-indigo-500 to-violet-500 text-white rounded-xl font-semibold text-sm sm:text-base tracking-wide transition-all duration-300 shadow-md hover:from-blue-700 hover:via-indigo-600 hover:to-violet-600 hover:shadow-xl hover:-translate-y-0.5 min-h-[44px] w-full sm:w-auto max-w-[300px] sm:max-w-none"
       {% if include.primary_subject %}aria-label="{{ include.primary_text }} - {{ include.primary_subject }}"{% endif %}>
      {{ include.primary_text | default: "Get Started" }}
    </a>
  {% endif %}

  {% if include.secondary_text and include.secondary_link %}
    <a href="{{ include.secondary_link }}"
       class="inline-flex items-center justify-center gap-2 px-6 sm:px-8 py-4 bg-white/90 backdrop-blur text-slate-900 border border-slate-300 rounded-xl font-semibold text-sm sm:text-base tracking-wide transition-all duration-300 shadow-sm hover:bg-slate-900 hover:text-white hover:border-slate-900 hover:shadow-md hover:-translate-y-0.5 min-h-[44px] w-full sm:w-auto max-w-[300px] sm:max-w-none"
       aria-label="{{ include.secondary_text }}">
      {{ include.secondary_text | default: "Learn More" }}
    </a>
  {% endif %}
</div>

<!-- Contact Info Display -->
{% if include.info %}
  <div class="text-center mt-8 p-6 bg-white/10 rounded-2xl backdrop-blur-md">
    {% if include.info.highlight %}
      <p class="text-slate-100 mb-3">
        <strong>{{ include.info.highlight }}</strong>
      </p>
    {% endif %}
    {% if include.info.tagline %}
      <p class="italic text-slate-300">
        {{ include.info.tagline }}
      </p>
    {% endif %}
  </div>
{% endif %}
```

**Step 2: Verify buttons display correctly**

Run: `bundle exec jekyll serve`
Expected: Buttons render with gradient and responsive sizing

**Step 3: Commit**

```bash
git add _includes/contact-buttons.html
git commit -m "$(cat <<'EOF'
feat: convert contact-buttons to Tailwind classes

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Task 7: Convert Default Layout

**Files:**
- Modify: `_layouts/default.html`

**Step 1: Update body and container structure in default.html**

Replace the body content (keep the head as modified in Task 1):

```html
<body class="font-sans text-base leading-relaxed text-slate-100 bg-slate-900 antialiased relative w-full max-w-full overflow-x-hidden">
  <!-- Skip to main content link for keyboard users -->
  <a href="#main-content" class="absolute -top-24 left-1.5 bg-black text-white px-3 py-2 no-underline rounded z-[1000] font-semibold text-sm focus:top-1.5 focus:outline focus:outline-2 focus:outline-white focus:outline-offset-2">{{ site.text.skip_to_content }}</a>

  {% include mesh-background.html %}

  <div class="min-h-screen flex flex-col relative z-[1] w-full overflow-x-hidden">
    {% include navigation.html %}

    <main class="flex-1 w-full max-w-full overflow-x-hidden" id="main-content" role="main" tabindex="-1">
      {{ content }}
    </main>

    {% include footer.html %}
  </div>

</body>
```

**Step 2: Verify the layout structure works**

Run: `bundle exec jekyll serve`
Expected: Page displays with proper layout structure

**Step 3: Commit**

```bash
git add _layouts/default.html
git commit -m "$(cat <<'EOF'
feat: convert default layout body to Tailwind classes

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Task 8: Convert Service Layout

**Files:**
- Modify: `_layouts/service.html`

**Step 1: Replace service.html with Tailwind classes**

```html
---
layout: default
---

<!-- Service Page Layout -->
<div class="text-slate-100">
  <!-- Hero Section -->
  {% include page-hero.html %}

  <!-- Value Proposition -->
  {% if page.value_prop %}
    {% include content-grid.html
      title=page.value_prop.title
      subtitle=page.value_prop.subtitle
      section_class="about-section" %}
  {% endif %}

  <!-- Services Grid -->
  {% if page.services %}
    {% include content-grid.html
      title=page.services.title
      items=page.services.items
      section_class="achievements-section"
      grid_class="achievement-grid"
      item_class="achievement-item" %}
  {% endif %}

  <!-- Custom content sections -->
  {% if content and content != empty %}
    <section class="w-full py-16 md:py-20 bg-white/95 backdrop-blur-lg border-t border-white/20">
      <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6 prose prose-slate max-w-none prose-headings:text-slate-900 prose-p:text-slate-600 prose-strong:text-slate-900 prose-a:text-violet-600 hover:prose-a:text-violet-700">
        {{ content }}
      </div>
    </section>
  {% endif %}

  <!-- CTA Section -->
  {% if page.cta %}
    <section class="w-full py-16 md:py-20 bg-slate-900/90 backdrop-blur-xl border-t border-white/10">
      <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
        <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-50 mb-8 pl-4 relative before:content-[''] before:absolute before:left-0 before:top-0 before:bottom-0 before:w-1 before:bg-gradient-to-b before:from-blue-500 before:to-violet-500 before:rounded">{{ page.cta.title | default: "Ready to Get Started?" }}</h2>
        <div class="text-center mb-10">
          <p class="text-lg text-slate-200">{{ page.cta.description }}</p>
        </div>
        {% capture primary_link %}mailto:{{ site.social.email }}?subject={{ page.cta.subject | url_encode }}{% endcapture %}
        {% capture secondary_link %}{{ '/projects' | relative_url }}{% endcapture %}

        {% include contact-buttons.html
           primary_text=page.cta.primary_button
           primary_link=primary_link
           primary_subject=page.cta.subject
           secondary_text=page.cta.secondary_button
           secondary_link=secondary_link
           info=page.cta.info %}
      </div>
    </section>
  {% endif %}
</div>
```

**Step 2: Verify service pages render correctly**

Run: `bundle exec jekyll serve`
Navigate to `/about`, `/projects`, etc.
Expected: Service pages display with proper sections

**Step 3: Commit**

```bash
git add _layouts/service.html
git commit -m "$(cat <<'EOF'
feat: convert service layout to Tailwind classes

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Task 9: Convert Post Layout

**Files:**
- Modify: `_layouts/post.html`

**Step 1: Replace post.html with Tailwind classes**

```html
---
layout: default
---

<div class="text-slate-100">
  <!-- Hero Section -->
  {% include page-hero.html
    title=page.title
    subtitle=page.subtitle
    date=page.date %}

  <!-- Article Content -->
  <section class="w-full py-16 md:py-20 bg-white/95 backdrop-blur-lg border-t border-white/20">
    <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
      <article class="max-w-3xl mx-auto prose prose-lg prose-slate prose-headings:text-slate-900 prose-p:text-slate-600 prose-strong:text-slate-900 prose-a:text-violet-600 hover:prose-a:text-violet-700 prose-blockquote:text-slate-700 prose-blockquote:border-violet-500">
        {{ content }}
      </article>

      <!-- Author Signature -->
      <div class="max-w-3xl mx-auto mt-12 p-8 bg-slate-50 rounded-lg border-l-4 border-violet-500">
        <div class="flex items-start gap-4">
          <img src="{{ site.author.avatar | relative_url }}" alt="{{ site.author.name }}" class="w-14 h-14 rounded-full object-cover">
          <div class="flex-1">
            <h4 class="m-0 mb-2 text-slate-900 text-lg font-semibold">{{ site.author.name }}</h4>
            <p class="m-0 mb-4 text-slate-600 text-sm leading-relaxed">{{ site.author.bio }}</p>
            <div class="flex gap-4 flex-wrap">
              {% if site.author.website %}
                <a href="{{ site.author.website }}" target="_blank" rel="noopener" class="text-violet-600 no-underline text-sm hover:text-violet-700">Website</a>
              {% endif %}
              {% if site.author.linkedin %}
                <a href="https://linkedin.com/in/{{ site.author.linkedin }}" target="_blank" rel="noopener" class="text-violet-600 no-underline text-sm hover:text-violet-700">LinkedIn</a>
              {% endif %}
              {% if site.author.github %}
                <a href="https://github.com/{{ site.author.github }}" target="_blank" rel="noopener" class="text-violet-600 no-underline text-sm hover:text-violet-700">GitHub</a>
              {% endif %}
              {% if site.author.twitter %}
                <a href="https://twitter.com/{{ site.author.twitter }}" target="_blank" rel="noopener" class="text-violet-600 no-underline text-sm hover:text-violet-700">Twitter</a>
              {% endif %}
            </div>
          </div>
        </div>
      </div>

      <div class="text-center mt-12 pt-8 border-t border-slate-200">
        <a href="{{ '/blog' | relative_url }}" class="inline-flex items-center justify-center gap-2 px-6 py-3 bg-slate-800 text-white rounded-xl font-semibold text-sm transition-all duration-300 hover:bg-slate-900 hover:shadow-md">← Back to Blog</a>
      </div>
    </div>
  </section>
</div>
```

**Step 2: Verify blog posts render correctly**

Run: `bundle exec jekyll serve`
Expected: Blog posts display with proper typography

**Step 3: Commit**

```bash
git add _layouts/post.html
git commit -m "$(cat <<'EOF'
feat: convert post layout to Tailwind classes

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Task 10: Convert Homepage (index.md)

**Files:**
- Modify: `index.md`

**Step 1: Replace index.md with Tailwind classes**

```markdown
---
layout: default
title: Steve Regester - Technical Co-Founder & Engineering Leader | OSINT, Security, React Development
description: Technical co-founder and engineering leader specializing in OSINT solutions, application security, and rapid React development. Proven track record building and scaling technology companies from idea to revenue.
keywords: technical co-founder, OSINT solutions, application security assessment, React Node.js development, N8N automation, digital intelligence, founding engineer services
sitemap:
  priority: 1.0
  changefreq: weekly
  lastmod: true
type: service
---

<div class="text-slate-100">

<!-- Professional Hero Section -->
<section class="w-full min-h-[70vh] md:min-h-[85vh] py-8 md:py-16 flex items-center">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    <header class="hero" role="banner">
      <div class="flex flex-col md:flex-row items-center gap-8 md:gap-12 text-center md:text-left">
        <div class="flex-1 order-2 md:order-1">
          <h1 class="text-3xl sm:text-4xl lg:text-5xl font-bold text-white mb-6 tracking-tight leading-tight">Technical Co-Founder & Engineering Leader</h1>
          <h2 class="text-xl sm:text-2xl lg:text-3xl font-semibold text-slate-100 mb-8 opacity-90">OSINT Solutions • Application Security • Rapid Development</h2>
          <p class="text-lg sm:text-xl text-slate-200 max-w-3xl leading-relaxed opacity-90">
            I build technology companies and specialized technical solutions for complex challenges<br>
            From OSINT intelligence platforms to secure React applications and automated workflows<br>
            <span class="text-slate-200 font-medium italic opacity-80 mt-2 inline-block">Available for co-founder partnerships, fractional CTO roles, and project-based development</span>
          </p>
        </div>
        <div class="flex-shrink-0 order-1 md:order-2">
          <img src="{{ '/assets/images/steve-regester-headshot.png' | relative_url }}" alt="Steve Regester - Technical Co-Founder & Engineering Leader" class="w-48 h-72 sm:w-56 sm:h-84 lg:w-64 lg:h-96 object-cover rounded-2xl border-[3px] border-white/30 shadow-xl transition-all duration-300 hover:scale-105 hover:shadow-2xl hover:border-indigo-500/50">
        </div>
      </div>
    </header>
  </div>
</section>

<!-- Value Proposition -->
<section class="w-full py-16 md:py-20 bg-white/95 backdrop-blur-lg border-t border-white/20 border-b border-white/10">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-900 mb-8 text-center relative after:content-[''] after:block after:w-24 after:h-1 after:bg-gradient-to-r after:from-blue-600 after:via-indigo-500 after:to-violet-500 after:mx-auto after:mt-6 after:rounded">Accelerate Growth with Expert Technology Consulting</h2>
    <p class="text-lg text-slate-600 text-center max-w-4xl mx-auto mb-10 leading-relaxed">
      As a seasoned engineering leader with extensive experience building enterprise-scale systems, I provide comprehensive technology consulting services to help businesses grow and thrive. From startup development and full-stack engineering to business automation, cybersecurity, and OSINT solutions, I deliver strategic technical guidance that transforms challenges into competitive advantages.
    </p>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8 lg:gap-10 mt-8 sm:mt-12" role="list">
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <strong class="text-slate-900 font-bold mb-4 block"><span>🚀</span> Startup Consulting</strong>
        <span class="text-slate-600 leading-relaxed block mb-6">Founding engineer services, CTO consulting, MVP development, 0-1 product strategy, technical co-founder expertise for early-stage startups</span>
        <div class="mt-auto">
          <a href="{{ '/startup-consulting' | relative_url }}" class="inline-flex items-center justify-center gap-2 px-6 py-3 bg-slate-800 text-white rounded-xl font-semibold text-sm transition-all duration-300 hover:bg-gradient-to-r hover:from-emerald-500 hover:to-blue-500 hover:shadow-lg w-full">Learn More →</a>
        </div>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <strong class="text-slate-900 font-bold mb-4 block"><span>💻</span> Full-Stack Engineering</strong>
        <span class="text-slate-600 leading-relaxed block mb-6">End-to-end application development, React/Node.js expertise, database design, cloud deployment, and scalable architecture solutions</span>
        <div class="mt-auto">
          <a href="{{ '/fullstack-engineering' | relative_url }}" class="inline-flex items-center justify-center gap-2 px-6 py-3 bg-slate-800 text-white rounded-xl font-semibold text-sm transition-all duration-300 hover:bg-gradient-to-r hover:from-emerald-500 hover:to-blue-500 hover:shadow-lg w-full">Learn More →</a>
        </div>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <strong class="text-slate-900 font-bold mb-4 block"><span>⚡</span> Business Automation</strong>
        <span class="text-slate-600 leading-relaxed block mb-6">Workflow automation, system integration, process optimization, custom automation solutions to streamline operations and boost efficiency</span>
        <div class="mt-auto">
          <a href="{{ '/n8n-consulting' | relative_url }}" class="inline-flex items-center justify-center gap-2 px-6 py-3 bg-slate-800 text-white rounded-xl font-semibold text-sm transition-all duration-300 hover:bg-gradient-to-r hover:from-emerald-500 hover:to-blue-500 hover:shadow-lg w-full">Learn More →</a>
        </div>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <strong class="text-slate-900 font-bold mb-4 block"><span>🔒</span> Security & Code Review</strong>
        <span class="text-slate-600 leading-relaxed block mb-6">Comprehensive code review, security testing, vulnerability assessment, threat modeling, and secure development consulting for teams</span>
        <div class="mt-auto">
          <a href="{{ '/penetration-testing' | relative_url }}" class="inline-flex items-center justify-center gap-2 px-6 py-3 bg-slate-800 text-white rounded-xl font-semibold text-sm transition-all duration-300 hover:bg-gradient-to-r hover:from-emerald-500 hover:to-blue-500 hover:shadow-lg w-full">Learn More →</a>
        </div>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <strong class="text-slate-900 font-bold mb-4 block"><span>🔍</span> OSINT & Digital Intelligence</strong>
        <span class="text-slate-600 leading-relaxed block mb-6">Open source intelligence platforms, digital surveillance solutions, real-time monitoring, and professional intelligence gathering systems</span>
        <div class="mt-auto">
          <a href="{{ '/osint-solutions' | relative_url }}" class="inline-flex items-center justify-center gap-2 px-6 py-3 bg-slate-800 text-white rounded-xl font-semibold text-sm transition-all duration-300 hover:bg-gradient-to-r hover:from-emerald-500 hover:to-blue-500 hover:shadow-lg w-full">Learn More →</a>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Results Section -->
<section class="w-full py-16 md:py-20 bg-slate-50/90 backdrop-blur-md border-t border-white/30 border-b border-white/20">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-900 mb-8 pl-4 relative before:content-[''] before:absolute before:left-0 before:top-0 before:bottom-0 before:w-1 before:bg-gradient-to-b before:from-blue-500 before:to-violet-500 before:rounded">Proven Results Across All Services</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8 lg:gap-10 mt-8 sm:mt-12" role="list">
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <strong class="text-slate-900 font-bold mb-4 block">Accelerated Development</strong>
        <span class="text-slate-600 leading-relaxed block">Rapid MVP development, automated workflows, and secure implementations that get you to market faster</span>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <strong class="text-slate-900 font-bold mb-4 block">Scalable Solutions</strong>
        <span class="text-slate-600 leading-relaxed block">Architecture and automation that grows with your business, from startup to enterprise scale</span>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <strong class="text-slate-900 font-bold mb-4 block">Risk Mitigation</strong>
        <span class="text-slate-600 leading-relaxed block">Proactive security testing, robust automation, and technical leadership that prevent costly issues</span>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <strong class="text-slate-900 font-bold mb-4 block">Operational Efficiency</strong>
        <span class="text-slate-600 leading-relaxed block">Streamlined processes through automation and optimized development practices that maximize productivity</span>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <strong class="text-slate-900 font-bold mb-4 block">Technical Excellence</strong>
        <span class="text-slate-600 leading-relaxed block">Enterprise-grade security, reliable automation systems, and startup-ready architecture delivered consistently</span>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <strong class="text-slate-900 font-bold mb-4 block">Strategic Growth Support</strong>
        <span class="text-slate-600 leading-relaxed block">Technology decisions that support fundraising, compliance requirements, and long-term business objectives</span>
      </div>
    </div>
  </div>
</section>

<!-- Expertise Section -->
<section class="w-full py-16 md:py-20 bg-white/95 backdrop-blur-lg border-t border-white/20 border-b border-white/10">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-900 mb-8 pl-4 relative before:content-[''] before:absolute before:left-0 before:top-0 before:bottom-0 before:w-1 before:bg-gradient-to-b before:from-blue-500 before:to-violet-500 before:rounded">Comprehensive Technology Expertise</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8 lg:gap-10 mt-8 sm:mt-12" role="list">
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <h3 class="text-violet-600 text-lg font-semibold mb-3"><span class="mr-2">🎯</span>Startup Development</h3>
        <p class="text-slate-600 text-sm leading-relaxed m-0">0-1 product development, MVP architecture, founding engineer services, CTO consulting, technical co-founder guidance</p>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <h3 class="text-violet-600 text-lg font-semibold mb-3"><span class="mr-2">⚡</span>Business Automation</h3>
        <p class="text-slate-600 text-sm leading-relaxed m-0">N8N workflow automation, system integration, process optimization, custom automation solutions, operational efficiency</p>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <h3 class="text-violet-600 text-lg font-semibold mb-3"><span class="mr-2">🔒</span>Security & Testing</h3>
        <p class="text-slate-600 text-sm leading-relaxed m-0">Professional penetration testing, physical security assessment, cybersecurity consulting, vulnerability analysis</p>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <h3 class="text-violet-600 text-lg font-semibold mb-3"><span class="mr-2">🔍</span>OSINT & Intelligence</h3>
        <p class="text-slate-600 text-sm leading-relaxed m-0">Open source intelligence platforms, digital surveillance, audio monitoring, real-time transcription, intelligence analysis</p>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <h3 class="text-violet-600 text-lg font-semibold mb-3"><span class="mr-2">🏗️</span>Software Architecture</h3>
        <p class="text-slate-600 text-sm leading-relaxed m-0">Scalable system design, cloud architecture, microservices, DevOps, CI/CD pipelines, infrastructure as code</p>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <h3 class="text-violet-600 text-lg font-semibold mb-3"><span class="mr-2">🔧</span>Full-Stack Development</h3>
        <p class="text-slate-600 text-sm leading-relaxed m-0">React, Node.js, Python, AWS, modern development technologies, rapid prototyping, technical implementation</p>
      </div>
      <div class="bg-gradient-to-br from-white/25 via-white/10 to-white/5 backdrop-blur-lg border border-white/20 rounded-2xl p-6 sm:p-8 shadow-md transition-all duration-300 hover:-translate-y-1.5 hover:scale-[1.02] hover:shadow-2xl hover:border-indigo-500/30 hover:bg-white/40" role="listitem">
        <h3 class="text-violet-600 text-lg font-semibold mb-3"><span class="mr-2">👥</span>Technical Leadership</h3>
        <p class="text-slate-600 text-sm leading-relaxed m-0">Team building, engineering culture, mentoring, process optimization, strategic technical decision-making</p>
      </div>
    </div>
  </div>
</section>

<!-- Professional CTA -->
<section class="w-full py-16 md:py-20 bg-slate-900/90 backdrop-blur-xl border-t border-white/10">
  <div class="w-full px-4 md:max-w-6xl md:mx-auto md:px-6">
    <h2 class="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-50 mb-8 pl-4 relative before:content-[''] before:absolute before:left-0 before:top-0 before:bottom-0 before:w-1 before:bg-gradient-to-b before:from-blue-500 before:to-violet-500 before:rounded">Ready to Transform Your Business?</h2>
    <div class="text-center mb-10">
      <p class="text-lg text-slate-200">
        Let's discuss your technology challenges and explore how expert consulting across startups, automation, security, and intelligence solutions can accelerate your business growth.
      </p>
    </div>
    <div class="flex justify-center gap-4 flex-wrap my-12 flex-col sm:flex-row items-center" role="list">
      <a href="mailto:{{ site.social.email }}?subject=Technology%20Consulting%20Services" class="inline-flex items-center justify-center gap-2 px-6 sm:px-8 py-4 bg-gradient-to-r from-blue-600 via-indigo-500 to-violet-500 text-white rounded-xl font-semibold text-sm sm:text-base tracking-wide transition-all duration-300 shadow-md hover:from-blue-700 hover:via-indigo-600 hover:to-violet-600 hover:shadow-xl hover:-translate-y-0.5 min-h-[44px] w-full sm:w-auto max-w-[300px] sm:max-w-none" role="listitem">Schedule Consultation</a>
      <a href="{{ '/projects' | relative_url }}" class="inline-flex items-center justify-center gap-2 px-6 sm:px-8 py-4 bg-white/90 backdrop-blur text-slate-900 border border-slate-300 rounded-xl font-semibold text-sm sm:text-base tracking-wide transition-all duration-300 shadow-sm hover:bg-slate-900 hover:text-white hover:border-slate-900 hover:shadow-md hover:-translate-y-0.5 min-h-[44px] w-full sm:w-auto max-w-[300px] sm:max-w-none" role="listitem">View Projects</a>
    </div>
    <div class="text-center">
      <p class="text-slate-100"><strong>Free Consultation • Startup Services • Automation • Security Testing • OSINT Solutions</strong></p>
      <p class="text-slate-300 italic">Transforming businesses through comprehensive technology consulting</p>
    </div>
  </div>
</section>

</div>
```

**Step 2: Verify homepage renders correctly**

Run: `bundle exec jekyll serve`
Expected: Homepage displays with full styling

**Step 3: Commit**

```bash
git add index.md
git commit -m "$(cat <<'EOF'
feat: convert homepage to Tailwind classes

Full mobile-first responsive homepage with all sections.

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Task 11: Update Content Pages (about.md, blog.md, faq.md, projects.md)

**Files:**
- Modify: `about.md`
- Modify: `blog.md`
- Modify: `faq.md`
- Modify: `projects.md`

**Step 1: Update about.md to use Tailwind for custom sections**

The about.md file uses the service layout, but has custom content sections with inline styles. Update the inline styles to use Tailwind classes. The testimonial section needs updating:

Replace the testimonial blockquotes in about.md from:
```html
<blockquote style="font-style: italic; margin: 0; padding: 1rem 0;">
```
to:
```html
<blockquote class="italic m-0 py-4">
```

And replace:
```html
<p style="font-weight: bold; color: var(--color-primary); margin-top: 1rem;">
```
to:
```html
<p class="font-bold text-violet-600 mt-4">
```

**Step 2: Update blog.md empty state**

Replace:
```html
<div style="text-align: center; padding: 2rem;">
  <p style="color: #666; font-size: 1.1em;">No posts yet.</p>
</div>
```
with:
```html
<div class="text-center p-8">
  <p class="text-slate-500 text-lg">No posts yet.</p>
</div>
```

**Step 3: Update projects.md custom sections**

The projects.md file uses the service layout and should work correctly once the layouts are updated. Verify it renders properly.

**Step 4: Verify all content pages render correctly**

Run: `bundle exec jekyll serve`
Navigate to each page
Expected: All pages display correctly

**Step 5: Commit**

```bash
git add about.md blog.md faq.md projects.md
git commit -m "$(cat <<'EOF'
feat: convert content pages to Tailwind classes

Updated inline styles in about.md, blog.md, faq.md, projects.md.

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Task 12: Delete Old CSS Files

**Files:**
- Delete: `assets/css/style.scss`
- Delete: `assets/css/professional-homepage.scss`
- Delete: `_includes/accessibility-styles.html`

**Step 1: Delete the old CSS files**

```bash
rm assets/css/style.scss
rm assets/css/professional-homepage.scss
rm _includes/accessibility-styles.html
```

**Step 2: Verify site still works without old CSS**

Run: `bundle exec jekyll serve`
Expected: Site renders correctly using only Tailwind

**Step 3: Commit**

```bash
git add -A
git commit -m "$(cat <<'EOF'
chore: remove old SCSS/CSS files

All styling now uses Tailwind CDN classes.
Only custom CSS is minimal mesh background positioning.

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Task 13: Final Verification and Cleanup

**Step 1: Full site verification**

Run: `bundle exec jekyll serve`

Check all pages:
- [ ] Homepage (/)
- [ ] About (/about)
- [ ] Projects (/projects)
- [ ] Blog (/blog)
- [ ] FAQ (/faq)
- [ ] All 5 service pages

Verify:
- [ ] Mobile navigation works
- [ ] Desktop navigation works
- [ ] Mesh background animates
- [ ] Cards have hover effects
- [ ] Buttons have proper styling
- [ ] Typography is readable
- [ ] Colors match original design intent

**Step 2: Check for any remaining custom CSS**

```bash
grep -r "style=" _layouts/ _includes/ *.md --include="*.html" --include="*.md" | grep -v "stylesheet"
```

Expected: No inline styles (or only truly necessary ones for mesh background)

**Step 3: Verify no CSS file references remain**

```bash
grep -r "style.css\|professional-homepage.css" _layouts/ _includes/ *.md
```

Expected: No matches

**Step 4: Final commit**

```bash
git add -A
git commit -m "$(cat <<'EOF'
feat: complete Tailwind CSS migration

- Replaced ~2,400 lines of custom SCSS with Tailwind CDN classes
- Mobile-first responsive design preserved
- Accessibility features maintained (reduced motion, high contrast)
- Only custom CSS: minimal mesh background positioning (~10 lines)

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Summary

This plan converts ~2,400 lines of custom SCSS to Tailwind CDN utility classes while:

1. **Preserving the design** - Same colors, spacing, typography, and visual effects
2. **Mobile-first approach** - Base styles are mobile, responsive prefixes for larger screens
3. **Accessibility** - Maintained reduced motion support, focus indicators, skip links
4. **Zero custom CSS** (except ~10 lines for mesh background positioning)

The migration is broken into 13 incremental tasks with commits after each major component.
