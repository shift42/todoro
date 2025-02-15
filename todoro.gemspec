require_relative "lib/todoro/version"

Gem::Specification.new do |spec|
  spec.name        = "todoro"
  spec.version     = Todoro::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = [ "Despo Pentara", "Evangelos Giataganas" ]
  spec.email       = [ "despo@shift42.io", "evangelos@shift42.io" ]
  spec.homepage    = "https://github.com/shift42/todoro"
  spec.description = "A lightweight Rails engine that lets any model manage task lists and tasks with a simple, flexible API."
  spec.summary     = "Todoro is a lightweight Rails engine that makes it easy to add task lists and tasks to any model. It integrates seamlessly into any Rails app, offering a simple and flexible way to organize and track tasks."
  spec.license     = "MIT"

  spec.metadata    = {
    "homepage_uri"      => "https://github.com/shift42/todoro",
    "documentation_uri" => "https://rubydoc.info/github/shift42/todoro",
    "changelog_uri"     => "https://github.com/shift42/todoro/blob/main/CHANGELOG.md",
    "source_code_uri"   => "https://github.com/shift42/todoro",
    "bug_tracker_uri"   => "https://github.com/shift42/todoro/issues",
    "wiki_uri"          => "https://github.com/shift42/todoro/wiki"
  }

  spec.files         = Dir["{app,config,lib}/**/*", "CHANGELOG.md", "MIT-LICENSE", "README.md"]
  spec.require_paths = [ "lib" ]
  spec.required_ruby_version = '>= 2.7.0'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails",  "~> 7.2.1"
end
