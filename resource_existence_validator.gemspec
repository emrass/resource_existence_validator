$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "resource_existence_validator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "resource_existence_validator"
  s.version     = ResourceExistenceValidator::VERSION
  s.authors     = ["Enrico Mrass"]
  s.email       = ["enrico.mrass@gmail.com"]
  s.homepage    = "https://github.com/emrass/resource_existence_validator"
  s.summary     = "Validate that an associated record exists by its id"
  s.description = "This gem adds a <validate xy_id, resource_exists: true> validator"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
end
