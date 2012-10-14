#
# Adapted from http://charliepark.org/tags-in-jekyll/
# as well as the AssetTag stuff
#

class ReadFileTag < Liquid::Tag
  def initialize(tag_name, name, kind, tokens)
    @name = name.to_s.strip
    @kind = kind.to_s
    @tokens = tokens
  end

  def render(context)
  end

end

module Jekyll
  class Site
    attr_accessor :portfolio
  end

  # Read the portfolio images, titles, captions
  class PortfolioGenerator < Generator
    safe true

    def generate(site)
      site.config['portfolio'] = []
      dir = site.config['portfolio_dir'] || 'portfolio'
      suf = site.config['portfolio_image_suffixes'] ||
        %w[jpg jpeg JPG JPEG png PNG tiff TIFF pdf PDF]

      # caption suffixes
      capsuf = site.config['portfolio_caption_suffixes'] ||
        %w[txt TXT html HTML htm HTM]

      glob = "#{dir}/**.{#{suf*','}}"
      puts "glob = #{glob} ; dir = #{dir} PWD = #{Dir.pwd}"
      Dir[glob].each do |f|
        puts "portfolio image = #{f}"

        # See if there's a caption
        capglob = f.sub(/\.\w+$/, ".{#{capsuf*','}}")
        #puts "capglob = #{capglob}"
        cap = Dir[capglob].first
        #puts "got cap = #{cap}"
        captxt = cap ? File.read(cap) : ''
        #puts "got txt = #{captxt}"

        # Split into caption and title
        title, caption = captxt.split(/[\r\n]+/,2)

        # Add to the items
        site.config['portfolio'] << {
          'image'   => f,
          'caption' => caption,
          'title'   => title,
        }
      end
    rescue => e
      puts "!!! PortfolioGenerator caught exception: #{e}"
    end
    #def write_tag_index(site, dir, tag)
    #  index = TagIndex.new(site, site.source, dir, tag)
    #  index.render(site.layouts, site.site_payload)
    #  index.write(site.dest)
    #  site.pages << index
    #end
  end
end

