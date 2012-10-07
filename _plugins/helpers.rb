# Global helpers

# So can do =haml(myfile)
class Object
  def haml(filename)
    begin
      contents = File.read("#{filename}.haml")
      Haml::Engine.new(contents).render
    rescue => e
      puts "!!! HAML Error: #{e}"
    end
  end

  def part(filename)
    haml("_parts/#{filename}")
  end
end

