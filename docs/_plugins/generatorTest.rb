module GeneratorTest
  class Generator < Jekyll::Generator
    def generate(site)
      puts "Running generatorTest..."
      about = site.pages.find { |page| page.name == 'about.md'}
      var1 = 2
      var2 = 3
      about.testVar = var1 + var2
    end
  end
end
