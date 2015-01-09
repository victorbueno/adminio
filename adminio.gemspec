$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "adminio/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "adminio"
  s.version     = Adminio::VERSION
  s.authors     = ["Victor Hugo Bueno"]
  s.email       = ["victorbueno@gmail.com"]
  s.homepage    = "http://victorbueno.com"
  s.summary     = "Admin made easy"
  s.description = "Admin made easy"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "simple_form", "3.0.2"

  #s.add_development_dependency "sqlite3"
end
