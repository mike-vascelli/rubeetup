require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

task default: :spec

desc 'Runs all the specs and plays back canned responses to save time'
task test: :spec

desc 'Executes tests all the way to the Meetup server'
task :live_test do
  ENV['LIVE_TEST'] = 'true'
  Rake::Task[:spec].invoke
end