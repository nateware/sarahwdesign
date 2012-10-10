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
  class TagIndex < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir  = dir
      @name = "#{tag}.html"
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_index.html')
      self.data['tag'] = tag
      tag_title_prefix = site.config['tag_title_prefix'] || 'Posts Tagged &ldquo;'
      tag_title_suffix = site.config['tag_title_suffix'] || '&rdquo;'
      self.data['title'] = "#{tag_title_prefix}#{tag}#{tag_title_suffix}"
    end
  end

  # Read the portfolio images and/or 
  class PortfolioGenerator < Generator
    safe true
    def generate(site)




      if site.layouts.key? 'tag_index'
        dir = site.config['tag_dir'] || 'tag'
        site.tags.keys.each do |tag|
          write_tag_index(site, dir, tag)
        end
      end
    end
    def write_tag_index(site, dir, tag)
      index = TagIndex.new(site, site.source, dir, tag)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end
end
