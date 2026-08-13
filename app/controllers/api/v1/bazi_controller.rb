# frozen_string_literal: true

module Api
  module V1
    # Handles BaZi (Four Pillars of Destiny) calculation endpoints.
    class BaziController < ApplicationController
      def calculate
        if params[:birth_date].blank?
          render json: { error: 'birth_date parameter is required (Format: YYYY-MM-DD)' }, status: :bad_request
          return
        end

        result = BaziCalculatorService.new(**bazi_params).calculate
        render json: { success: true, data: result }, status: :ok
      rescue ArgumentError => e
        render json: { error: "Invalid date format: #{e.message}" }, status: :unprocessable_entity
      end

      private

      def bazi_params
        params.permit(:birth_date, :birth_time, :gender).to_h.symbolize_keys
      end
    end
  end
end
