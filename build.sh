#!/bin/bash

# Professional Jekyll Build Script with EXIF Processing
# Steve Regester - Technology Consulting & Engineering Leadership
# https://egeste.net

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${BLUE}[BUILD]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_info() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

# Banner
echo -e "${PURPLE}"
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║                    Professional Jekyll Build                     ║"
echo "║              Steve Regester Technology Consulting                ║"
echo "║                        https://egeste.net                        ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if we're in the right directory
if [ ! -f "_config.yml" ]; then
    print_error "Not in a Jekyll site directory (no _config.yml found)"
    exit 1
fi

# Check for required tools
print_step "Checking build dependencies..."

if ! command -v bundle >/dev/null 2>&1; then
    print_error "Bundler not found. Please install: gem install bundler"
    exit 1
fi

if ! command -v exiftool >/dev/null 2>&1; then
    print_warning "exiftool not found. Image metadata processing will be skipped."
    print_info "Install with: brew install exiftool (macOS) or apt-get install libimage-exiftool-perl (Ubuntu)"
fi

# Parse command line arguments
ENVIRONMENT="development"
CLEAN_BUILD=false
SERVE_AFTER=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --production|--prod)
            ENVIRONMENT="production"
            shift
            ;;
        --clean)
            CLEAN_BUILD=true
            shift
            ;;
        --serve)
            SERVE_AFTER=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --production, --prod    Build for production environment"
            echo "  --clean                 Clean build (remove _site directory first)"
            echo "  --serve                 Serve the site after building"
            echo "  --help, -h              Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                      # Development build"
            echo "  $0 --production         # Production build"
            echo "  $0 --clean --serve      # Clean build and serve"
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Set Jekyll environment
export JEKYLL_ENV=$ENVIRONMENT
print_info "Building for environment: $ENVIRONMENT"

# Clean build if requested
if [ "$CLEAN_BUILD" = true ]; then
    print_step "Cleaning previous build..."
    if [ -d "_site" ]; then
        rm -rf _site
        print_success "Cleaned _site directory"
    fi

    if [ -d ".jekyll-cache" ]; then
        rm -rf .jekyll-cache
        print_success "Cleaned .jekyll-cache directory"
    fi
fi

# Install/update dependencies
print_step "Installing/updating Ruby dependencies..."
if ! bundle install --quiet; then
    print_error "Bundle install failed"
    exit 1
fi
print_success "Dependencies updated"

# Build the site
print_step "Building Jekyll site..."
if [ "$ENVIRONMENT" = "production" ]; then
    BUILD_CMD="bundle exec jekyll build --trace"
else
    BUILD_CMD="bundle exec jekyll build --trace --incremental"
fi

if ! $BUILD_CMD; then
    print_error "Jekyll build failed"
    exit 1
fi

print_success "Jekyll build completed"

# Verify EXIF processing occurred
if command -v exiftool >/dev/null 2>&1; then
    print_step "Verifying EXIF processing..."

    # Check if any images were processed
    SAMPLE_IMAGE=$(find assets/images -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" | head -1)

    if [ -n "$SAMPLE_IMAGE" ] && [ -f "$SAMPLE_IMAGE" ]; then
        if exiftool "$SAMPLE_IMAGE" | grep -q "Steve Regester"; then
            print_success "EXIF metadata processing verified"
        else
            print_warning "EXIF metadata may not have been processed correctly"
        fi
    fi
fi

# Build summary
echo ""
print_success "Build completed successfully!"
print_info "Environment: $ENVIRONMENT"
print_info "Output directory: _site/"

# Serve if requested
if [ "$SERVE_AFTER" = true ]; then
    print_step "Starting development server..."
    print_info "Site will be available at: http://localhost:4000"
    print_info "Press Ctrl+C to stop the server"

    bundle exec jekyll serve --host 0.0.0.0 --port 4000 --livereload
fi

echo -e "${GREEN}"
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║                       Build Complete!                           ║"
echo "║              Professional site ready for deployment              ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"