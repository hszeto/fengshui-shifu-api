# frozen_string_literal: true

module Api
  module V1
    class BaziController < ApplicationController
      def calculate
        birth_date = params[:birth_date]
        gender = params[:gender] || 'male'

        if birth_date.blank?
          render json: { error: 'birth_date parameter is required (Format: YYYY-MM-DD)' }, status: :bad_request
          return
        end

        result = BaziCalculatorService.new(birth_date: birth_date, gender: gender).calculate
        render json: { success: true, data: result }, status: :ok
      rescue ArgumentError => e
        render json: { error: "Invalid date format: #{e.message}" }, status: :unprocessable_entity
      end
    end
  end
end
