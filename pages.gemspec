$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "no_cms/admin/pages/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nocms-pages-admin"
  s.version     = NoCms::Admin::Pages::VERSION
  s.authors     = ["Simplelogica"]
  s.email       = ["gems@simplelogica.net"]
  s.homepage    = "https://github.com/simplelogica/nocms-admin-pages"
  s.summary     = "Gem with custom back for nocms-pages gem"
  s.description = "Gem with custom back for nocms-pages gem"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "nocms-pages", '~> 0.0', '>= 0.0.1'
  s.add_dependency "nocms-admin", '~> 0.0', '>= 0.0.1'
  s.add_dependency "jquery-rails", '~> 3.1'

  s.add_development_dependency "sqlite3"
end
