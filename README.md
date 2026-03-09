# egeste.net

Personal portfolio and technology consulting site for Steve Regester. Built with Jekyll and deployed to GitHub Pages via GitHub Actions.

## Local Development

```bash
bundle install
bundle exec jekyll serve
```

Visit `http://localhost:4000` to preview locally.

## Deployment

Pushes to `master` trigger the GitHub Actions workflow (`.github/workflows/deploy.yml`), which builds the Jekyll site, processes EXIF metadata on images, and deploys to GitHub Pages.

## Structure

```
_config.yml          # Site configuration, professional data, SEO, PWA manifest
_layouts/            # Page layouts (default, post, service, resume-print)
_includes/           # Shared components (navigation, footer, mesh background, etc.)
_plugins/            # Jekyll plugins (EXIF image metadata processor)
_data/projects.yml   # Project portfolio data
_posts/              # Blog posts
assets/              # CSS, images, fonts
```

### Pages

- `index.md` — Landing page with service offerings
- `resume.md` / `resume/print.md` — Web and print-optimized resumes
- `about.md` — About page
- `blog.md` — Blog index
- `projects.md` — Project portfolio
- `faq.md` — FAQ
- Service pages: `startup-consulting.md`, `fullstack-engineering.md`, `n8n-consulting.md`, `penetration-testing.md`, `osint-solutions.md`

## License

MIT License - see LICENSE file for details.
