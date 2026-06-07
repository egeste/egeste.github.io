source "https://rubygems.org"

# Build Jekyll directly (deployment uses our own GitHub Actions build, not the
# github-pages native pipeline), so we can track patched, current dependencies
# instead of the frozen versions the github-pages meta-gem pins.
gem "jekyll", "~> 4.4"

group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.17"
  gem "jekyll-sitemap", "~> 1.4"
  gem "jekyll-seo-tag", "~> 2.8"
  gem "jekyll-redirect-from", "~> 0.16"
end

gem "webrick", "~> 1.9"
