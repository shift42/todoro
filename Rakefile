require "bundler/setup"

APP_RAKEFILE = File.expand_path("spec/todoapp/Rakefile", __dir__)
load "rails/tasks/engine.rake"

load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"

require 'rdoc/task'

desc 'Generate documentation for Todoro.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Todoro'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'rspec/core/rake_task'

# Define the "spec" task, at task load time rather than inside another task
RSpec::Core::RakeTask.new(:spec)

desc 'Run all tests'
task all_tests: :environment do
  ENV['RUN_ALL_TESTS'] = 'true'
  Rake::Task['spec'].invoke
end
