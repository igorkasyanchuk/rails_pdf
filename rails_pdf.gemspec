$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "rails_pdf/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_pdf"
  s.version     = RailsPDF::VERSION
  s.authors     = ["Igor Kasyanchuk"]
  s.email       = ["igorkasyanchuk@gmail.com"]
  s.homepage    = "https://github.com"
  s.summary     = "https://github.com"
  s.description = "https://github.com"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.0.0"
  s.add_dependency "better_tempfile"

  s.add_development_dependency "sqlite3"
end
