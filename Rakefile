require 'rubygems' unless ENV['NO_RUBYGEMS']

require 'bundler'
require 'rspec/core/rake_task'
require 'rubygems/package_task'

require './lib/activerecord-extensions'

Bundler::GemHelper.install_tasks

task :default => :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end

task :console do
  $:.push(File.dirname(__FILE__))

  require 'spec/env'
  require 'pry-nav'

  ActiverecordExtensions::Env.establish_connection
  ActiverecordExtensions::Env.reset
  ActiverecordExtensions::Env.migrate

  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end
