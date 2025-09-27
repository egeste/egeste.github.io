# Automated EXIF Processing System

This Jekyll site includes automated EXIF metadata processing to ensure all images are properly branded with professional metadata while maintaining security by removing potentially sensitive information.

## Overview

The EXIF processing system automatically:
- **Strips all existing EXIF data** from images (removes GPS, camera info, etc.)
- **Adds professional branding metadata** identifying images as assets from your website
- **Runs during every Jekyll build** ensuring consistent metadata across all images

## Components

### 1. Jekyll Plugin (`_plugins/exif_processor.rb`)
- Hooks into Jekyll's build process using `post_write` hook
- Processes all images in the `assets/images/` directory
- Configurable via `_config.yml`
- Provides detailed logging during build

### 2. Build Script (`build.sh`)
- Professional build script with colored output
- Checks dependencies (bundler, exiftool)
- Supports multiple build modes
- Verifies EXIF processing completion

### 3. Configuration (`_config.yml`)
- `exif_processing` section controls behavior
- Customizable metadata fields
- File type and path exclusions

## Usage

### Using the Build Script (Recommended)
```bash
# Basic development build
./build.sh

# Production build
./build.sh --production

# Clean build and serve
./build.sh --clean --serve

# Help
./build.sh --help
```

### Using Jekyll Directly
```bash
# Standard Jekyll build (EXIF processing runs automatically)
bundle exec jekyll build

# Development server
bundle exec jekyll serve
```

## Configuration

### EXIF Processing Settings (`_config.yml`)
```yaml
exif_processing:
  enabled: true                           # Enable/disable processing
  image_extensions: [jpg, jpeg, png, webp]  # File types to process
  exclude_paths: ['_site/', 'vendor/']      # Paths to skip
  metadata:
    creator: "Steve Regester"
    copyright: "© 2025 Steve Regester - Technology Consulting"
    source: "https://egeste.net"
    # ... additional metadata fields
```

### Supported Metadata Fields
- `creator` - Image creator/author
- `artist` - Artist name
- `copyright` - Copyright notice
- `copyright_notice` - Additional copyright info
- `rights` - Rights statement
- `source` - Source URL/website
- `credit` - Credit line
- `contact` - Contact information
- `keywords` - Comma-separated keywords
- `subject` - Image subject/description
- `title` - Image title
- `description` - Detailed description

## Security Benefits

### Privacy Protection
- Removes GPS coordinates from photos
- Strips camera make/model information
- Eliminates timestamps and technical metadata
- Removes software information

### Professional Branding
- Consistent metadata across all images
- Copyright protection
- Source attribution
- Contact information for licensing

## Requirements

### System Dependencies
- **Ruby** (for Jekyll)
- **Bundler** (gem dependency management)
- **ExifTool** (metadata processing)

### Installing ExifTool
```bash
# macOS
brew install exiftool

# Ubuntu/Debian
sudo apt-get install libimage-exiftool-perl

# Other systems
# Download from https://exiftool.org/
```

## Troubleshooting

### EXIF Processing Skipped
If you see warnings about skipped processing:

1. **Check ExifTool installation:**
   ```bash
   which exiftool
   exiftool -ver
   ```

2. **Verify configuration:**
   - Ensure `exif_processing.enabled: true` in `_config.yml`
   - Check that image files exist in `assets/images/`

3. **Check build logs:**
   - Look for "EXIF Processor" messages during build
   - Run `./build.sh` for detailed output

### Build Issues
- Ensure all dependencies are installed: `bundle install`
- Clear caches: `./build.sh --clean`
- Check Ruby version compatibility

## Customization

### Adding New Image Types
Edit `_config.yml`:
```yaml
exif_processing:
  image_extensions: [jpg, jpeg, png, webp, gif, tiff]
```

### Excluding Additional Paths
```yaml
exif_processing:
  exclude_paths: ['_site/', 'vendor/', 'temp/', 'backup/']
```

### Disabling for Development
```yaml
exif_processing:
  enabled: false  # Temporarily disable processing
```

## Build Integration

The EXIF processing system integrates seamlessly with:
- **GitHub Pages** (if ExifTool is available)
- **Netlify** (with build script configuration)
- **Local development** (immediate processing)
- **CI/CD pipelines** (automated deployment)

## Metadata Verification

To verify metadata was applied correctly:
```bash
# Check a specific image
exiftool assets/images/your-image.png

# Find images with your branding
find assets/images -name "*.png" -exec exiftool {} \; | grep "Steve Regester"
```

## Performance Notes

- Processing adds ~1-2 seconds to build time
- Only processes images that have changed (when possible)
- Minimal impact on final image file sizes
- No quality loss during processing

---

**Professional Jekyll Site**
Steve Regester - Technology Consulting & Engineering Leadership
https://egeste.net