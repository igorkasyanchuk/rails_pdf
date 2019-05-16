$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "rails_pdf/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_pdf"
  s.version     = RailsPDF::VERSION
  s.authors     = ["Igor Kasyanchuk"]
  s.email       = ["igorkasyanchuk@gmail.com"]
  s.homepage    = "https://github.com/igorkasyanchuk/rails_pdf"
  s.summary     = "Reliable way to generate PDF files of any complexity."
  s.description = "Reliable way to generate PDF files of any complexity. Support HTML/ERB/CSS/SCSS/PUG/Javascript/ChartsJS/Images/SVG/Custom Fonts/etc."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.2.0"
  s.add_dependency "better_tempfile"

  s.add_development_dependency "sqlite3"
end
