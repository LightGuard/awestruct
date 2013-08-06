require 'rubygems'
require 'rspec'
require 'rspec/expectations'
require 'logger'
require 'fileutils'

Dir["./spec/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before :all do
    FileUtils.mkdir('.awestruct') unless File.exists? '.awestruct'
    $LOG = Logger.new('.awestruct/test.log')
  end
  config.mock_framework = :rspec
  config.include NokogiriMatchers
  config.include EmmetMatchers
  config.after :all do
    FileUtils.rm_rf '.awestruct' if File.exists? '.awestruct'
  end
end
