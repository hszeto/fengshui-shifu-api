# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Health', type: :request do
  describe 'GET /api/v1/health' do
    it 'returns http success with service health status' do
      get '/api/v1/health'

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['status']).to eq('ok')
      expect(json['service']).to eq('fengshui-shifu-api')
      expect(json['timestamp']).to be_present
    end
  end
end
