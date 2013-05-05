require "rubygems"
require "bundler"

Bundler.setup(:default, :test)

require 'simplecov'
SimpleCov.start do
  add_filter "spec"
end

require "sinatra"
require "rspec"
require "rack"
require "rack/test"
require "pry"
require File.expand_path("../../lib/sinatra/zero_clipboard", __FILE__)

# setting up test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false

module Sinatra::ZeroClipboard::RSpecHelper
  def app(reset = false)
    @test_app = Class.new(Sinatra::Application) if reset || @test_app.nil?
    @test_app
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Sinatra::ZeroClipboard::RSpecHelper
end
