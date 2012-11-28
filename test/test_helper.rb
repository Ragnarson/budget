ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.start

require 'capybara/rails'
require 'capybara/dsl'
require 'capybara/poltergeist'
Capybara.current_driver = :poltergeist

class ActiveSupport::TestCase
  fixtures :all
end

class ActionController::TestCase
  include Devise::TestHelpers
  include ActionView::Helpers::NumberHelper
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  self.use_transactional_fixtures = false

  teardown do
    DatabaseCleaner.clean
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  private
  def allow_google_login_as(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OpenStruct.new({info: {'email' => user.email}})
  end
end
