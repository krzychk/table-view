$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "table_view/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "table_view"
  s.version     = TableView::VERSION
  s.authors     = ["Krzysztof Kotlarski"]
  s.email       = ["kotlarski.krzysztof@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "Table view"
  s.description = "Table view"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"

  s.add_development_dependency "sqlite3"
end
