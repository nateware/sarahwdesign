# https://github.com/rweng/jekyll-haml-scss-sample/blob/master/_plugins/sass_converter.rb
module Jekyll
  # Sass plugin to convert .scss to .css
  #
  # Note: This is configured to use the new css like syntax available in sass.
  require 'sass'
  class SassConverter < Converter
    safe true
    priority :low

     def matches(ext)
      ext =~ /scss/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      begin
        puts "Performing SASS Conversion."
        engine = Sass::Engine.new(content, :syntax => :scss)
        engine.render
      rescue StandardError => e
        puts "!!! SASS Error: " + e.message
      end
    end
  end
end