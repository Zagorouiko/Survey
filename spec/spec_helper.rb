ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'pg'
require("sinatra/activerecord")
require 'survey'
require 'question'


RSpec.configure do |config|
  config.after(:each) do
    Survey.all().each() do |employee|
      employee.destroy()
    end
    Question.all().each() do |division|
      division.destroy()
    end
  end
end
