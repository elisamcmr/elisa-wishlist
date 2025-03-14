require 'open-uri'

class ImageExtractorService
  def self.extract_and_attach(item, url)
    doc = Nokogiri::HTML(URI.open(url))
    image_urls = []

    # Collect all potential image URLs
    # Open Graph images
    image_urls += doc.css('meta[property="og:image"]').map { |meta| meta['content'] }

    # Twitter images
    image_urls += doc.css('meta[name="twitter:image"]').map { |meta| meta['content'] }

    # Schema.org images
    image_urls += doc.css('img[itemprop="image"]').map { |img| img['src'] }

    # Product images (common in e-commerce sites)
    image_urls += doc.css('.product-image img, .product-gallery img').map { |img| img['src'] }

    # Fallback to all images that seem large enough (filtering out tiny icons)
    doc.css('img').each do |img|
      width = img['width'].to_i
      height = img['height'].to_i
      if width > 100 && height > 100 || (!width.zero? && !height.zero?)
        image_urls << img['src']
      end
    end

    # Remove duplicates and nil values
    image_urls = image_urls.compact.uniq

    # Process each image
    image_urls.each_with_index do |image_url, index|
      next unless image_url

      # Convert relative URLs to absolute URLs
      image_url = URI.join(url, image_url).to_s unless image_url.start_with?('http')

      # Download and attach the image
      begin
        downloaded_image = URI.open(image_url)
        item.images.attach(
          io: downloaded_image,
          filename: "#{item.name.parameterize}-#{index + 1}.#{downloaded_image.content_type.split('/').last}"
        )
      rescue StandardError => e
        Rails.logger.error "Failed to download image #{index + 1}: #{e.message}"
      end
    end
  end
end 
