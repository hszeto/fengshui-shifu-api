# frozen_string_literal: true

require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"

Bundler.require(*Rails.groups)

module FengshuiShifuApi
  class Application < Rails::Application
    config.load_defaults 8.0
    config.api_only = true
    config.time_zone = 'UTC'
  end
end
