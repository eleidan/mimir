require "bundler/gem_tasks"
require "rspec/core/rake_task"

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
  puts "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
