$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "no_cms/admin/pages/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nocms-pages-admin"
  s.version     = NoCms::Admin::Pages::VERSION
  s.authors     = ["David J. Brenes"]
  s.email       = ["david.brenes@simplelogica.net"]
  s.homepage    = "http://www.simplelogica.net"
  s.summary     = "Gem with custom back for nocms-pages gem"
  s.description = "Gem with custom back for nocms-pages gem"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "nocms-pages", "~> 0.0.1"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
