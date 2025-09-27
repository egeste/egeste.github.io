# EXIF Processor Plugin for Jekyll
# Automatically processes image metadata during site generation
# Strips existing EXIF data and adds professional branding metadata

Jekyll::Hooks.register :site, :post_write do |site|
  # Configuration from _config.yml
  config = site.config['exif_processing'] || {}

  # Default configuration
  defaults = {
    'enabled' => true,
    'image_extensions' => %w[jpg jpeg png webp],
    'exclude_paths' => ['_site/', 'vendor/', 'node_modules/'],
    'metadata' => {
      'creator' => site.config.dig('author', 'name') || 'Steve Regester',
      'artist' => site.config.dig('author', 'name') || 'Steve Regester',
      'copyright' => "© #{Time.now.year} #{site.config.dig('author', 'name') || 'Steve Regester'} - Technology Consulting & Engineering Leadership",
      'copyright_notice' => "© #{Time.now.year} #{site.config.dig('author', 'name') || 'Steve Regester'} - Technology Consulting & Engineering Leadership",
      'rights' => "© #{Time.now.year} #{site.config.dig('author', 'name') || 'Steve Regester'} - Technology Consulting & Engineering Leadership",
      'source' => site.config['url'] || 'https://egeste.net',
      'credit' => "#{site.config['url'] || 'egeste.net'} - #{site.config.dig('author', 'name') || 'Steve Regester'} Technology Consulting",
      'contact' => site.config.dig('author', 'email') || site.config.dig('social', 'email') || 'info@egeste.net',
      'keywords' => 'technology consulting, engineering leadership, Steve Regester, Portland Oregon, startup consulting, full-stack development',
      'subject' => 'Professional technology consulting and engineering leadership services',
      'title' => "#{site.config.dig('author', 'name') || 'Steve Regester'} - Technology Consulting Asset",
      'description' => "Professional asset from #{site.config.dig('author', 'name') || 'Steve Regester'}'s technology consulting and engineering leadership portfolio"
    }
  }

  # Merge configuration with defaults
  settings = defaults.merge(config)

  # Skip if disabled
  unless settings['enabled']
    Jekyll.logger.info "EXIF Processor:", "Skipped (disabled in configuration)"
    return
  end

  # Check if exiftool is available
  unless system('which exiftool > /dev/null 2>&1')
    Jekyll.logger.warn "EXIF Processor:", "exiftool not found - skipping image processing"
    return
  end

  Jekyll.logger.info "EXIF Processor:", "Processing images..."

  # Find all image files in assets directory
  assets_dir = File.join(site.source, 'assets')
  return unless Dir.exist?(assets_dir)

  image_extensions = settings['image_extensions'].map { |ext| "*.#{ext}" }
  pattern = File.join(assets_dir, '**', "{#{image_extensions.join(',')}}")

  image_files = Dir.glob(pattern, File::FNM_CASEFOLD)

  # Filter out excluded paths
  image_files = image_files.reject do |file|
    settings['exclude_paths'].any? { |path| file.include?(path) }
  end

  processed_count = 0
  error_count = 0

  image_files.each do |image_file|
    begin
      # Skip if file doesn't exist (race condition protection)
      next unless File.exist?(image_file)

      # Build exiftool command to strip all metadata first
      strip_cmd = [
        'exiftool',
        '-all=',
        '-overwrite_original',
        image_file
      ]

      # Execute strip command
      unless system(*strip_cmd, out: File::NULL, err: File::NULL)
        Jekyll.logger.warn "EXIF Processor:", "Failed to strip metadata from #{File.basename(image_file)}"
        error_count += 1
        next
      end

      # Build exiftool command to add professional metadata
      add_cmd = ['exiftool', '-overwrite_original']

      settings['metadata'].each do |key, value|
        # Map keys to proper exiftool tags
        exif_key = case key
        when 'creator' then '-Creator'
        when 'artist' then '-Artist'
        when 'copyright' then '-Copyright'
        when 'copyright_notice' then '-CopyrightNotice'
        when 'rights' then '-Rights'
        when 'source' then '-Source'
        when 'credit' then '-Credit'
        when 'contact' then '-Contact'
        when 'keywords' then '-Keywords'
        when 'subject' then '-Subject'
        when 'title' then '-Title'
        when 'description' then '-Description'
        else next # Skip unknown keys
        end

        add_cmd << "#{exif_key}=#{value}"
      end

      add_cmd << image_file

      # Execute add metadata command
      if system(*add_cmd, out: File::NULL, err: File::NULL)
        processed_count += 1
      else
        Jekyll.logger.warn "EXIF Processor:", "Failed to add metadata to #{File.basename(image_file)}"
        error_count += 1
      end

    rescue => e
      Jekyll.logger.warn "EXIF Processor:", "Error processing #{File.basename(image_file)}: #{e.message}"
      error_count += 1
    end
  end

  # Report results
  if processed_count > 0
    Jekyll.logger.info "EXIF Processor:", "Successfully processed #{processed_count} image#{processed_count == 1 ? '' : 's'}"
  end

  if error_count > 0
    Jekyll.logger.warn "EXIF Processor:", "#{error_count} error#{error_count == 1 ? '' : 's'} encountered"
  end

  if processed_count == 0 && error_count == 0
    Jekyll.logger.info "EXIF Processor:", "No images found to process"
  end
end