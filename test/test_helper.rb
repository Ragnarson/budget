ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

class ActiveSupport::TestCase
  fixtures :all

  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.start
end

class ActionController::TestCase
  include Devise::TestHelpers
  include ActionView::Helpers::NumberHelper
end
