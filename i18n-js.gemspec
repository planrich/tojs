$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "i18n-js/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "i18n-js"
  s.version     = I18nJs::VERSION
  s.authors     = ["Richard Plangger"]
  s.email       = ["planrichi@gmail.com"]
  s.homepage    = ""
  s.summary     = "summary"
  s.description = "desc"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12"

  s.add_dependency "i18n"
  #s.add_development_dependency "sqlite3"
end
