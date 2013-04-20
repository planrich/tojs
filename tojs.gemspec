$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tojs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tojs"
  s.version     = ToJs::VERSION
  s.authors     = ["Richard Plangger"]
  s.email       = ["planrichi@gmail.com"]
  s.homepage    = "https://github.com/planrich/tojs"
  s.summary     = "Utility gem to move static data from rails to precompiled javascript"
  s.description = "Ever built a webpage making heavy use of client side javascript? This lib should expose some static data included in rails to the client runtime environment."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12"

  s.add_dependency "i18n"
end
