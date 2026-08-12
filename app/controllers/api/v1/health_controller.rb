# frozen_string_literal: true

module Api
  module V1
    class HealthController < ApplicationController
      def show
        render json: {
          status: 'ok',
          service: 'fengshui-shifu-api',
          timestamp: Time.now.iso8601,
          rails_version: Rails.version,
          ruby_version: RUBY_VERSION
        }, status: :ok
      end
    end
  end
end
