#
# Adapted from http://charliepark.org/tags-in-jekyll/
# as well as the AssetTag stuff
#
module Jekyll
  # Read the portfolio images, titles, captions
  class PortfolioGenerator < Generator
    safe true

    def generate(site)
      generate_via_conf(site)
    rescue => e
      puts "!!! PortfolioGenerator caught exception: #{e}"
    end

    def generate_via_conf(site)
      site.config['portfolio'] = []
      dir  = site.config['portfolio_dir'] || 'portfolio'
      suf  = site.config['portfolio_image_suffixes'] ||
        %w[jpg jpeg JPG JPEG png PNG tiff TIFF pdf PDF]
      conf = File.expand_path('portfolio.txt', dir)

      File.open(conf).each do |line|
        # Avoid comments, headers, etc
        next unless line =~ /^\s*\S+\.(#{suf * '|'})\b/

        f, title, caption = line.strip.split(/\s*\|\s*/, 3)

        # Add to the portfolio for the template
        site.config['portfolio'] << {
          'id'      => f.gsub(/\W+/,'_'),
          'image'   => "/#{dir}/#{f}",
          'title'   => title,
          'caption' => caption
        }
      end
    end

    # Unused
    def generate_via_glob(site)
      site.config['portfolio'] = []
      dir = site.config['portfolio_dir'] || 'portfolio'
      suf = site.config['portfolio_image_suffixes'] ||
        %w[jpg jpeg JPG JPEG png PNG tiff TIFF pdf PDF]

      # caption suffixes
      capsuf = site.config['portfolio_caption_suffixes'] ||
        %w[txt TXT html HTML htm HTM]

      glob = "#{dir}/**.{#{suf*','}}"

      #puts "glob = #{glob} ; dir = #{dir} PWD = #{Dir.pwd}"
      Dir[glob].sort.each do |f|
        #puts "portfolio image = #{f}"

        # See if there's a caption
        capglob = f.sub(/\.\w+$/, ".{#{capsuf*','}}")
        #puts "capglob = #{capglob}"
        cap = Dir[capglob].first
        #puts "got cap = #{cap}"
        captxt = cap ? File.read(cap) : ''
        #puts "got txt = #{captxt}"

        # Split into caption and title
        title, caption = captxt.split(/[\r\n]+/,2)

        # Add to the portfolio for the template
        site.config['portfolio'] << {
          'id'      => f.gsub(/\W+/,'_'),
          'image'   => f,
          'title'   => title,
          'caption' => caption
        }
      end
    end


    #def write_tag_index(site, dir, tag)
    #  index = TagIndex.new(site, site.source, dir, tag)
    #  index.render(site.layouts, site.site_payload)
    #  index.write(site.dest)
    #  site.pages << index
    #end
  end
end

