module Jekyll
  require 'haml'
  class HamlConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /haml/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      begin
        puts "Performing HAML Conversion."
        engine = Haml::Engine.new(content)
        engine.render
      rescue => e
        puts "!!! HAML Error: " + e.message
      end
    end
  end
end
