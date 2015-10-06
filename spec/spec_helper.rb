require 'rspec'
require 'activerecord-extensions'
require 'support/log_buffer'
require 'fileutils'
require 'pry-nav'

require 'env'

def silence(&block)
  original_stdout = $stdout
  $stdout = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
end

RSpec.configure do |config|
  config.mock_with :rr
  ActiveRecord::Base.logger = Logger.new(STDOUT)

  config.before(:each) do
    ActiverecordExtensions::Env.establish_connection
    ActiverecordExtensions::Env.reset
    silence { ActiverecordExtensions::Env.migrate }
  end
end
