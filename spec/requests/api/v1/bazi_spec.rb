# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Bazi', type: :request do
  describe 'POST /api/v1/bazi/calculate' do
    context 'with valid birth date' do
      it 'returns calculated Day Master & Kua profile' do
        post '/api/v1/bazi/calculate', params: { birth_date: '1990-01-01', gender: 'male' }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['success']).to be true
        expect(json['data']['day_master']['name']).to eq('Ren Water')
        expect(json['data']['kua_number']).to eq(7)
      end
    end

    context 'with missing birth date' do
      it 'returns 400 bad request error' do
        post '/api/v1/bazi/calculate', params: {}

        expect(response).to have_http_status(:bad_request)
        json = JSON.parse(response.body)
        expect(json['error']).to include('birth_date parameter is required')
      end
    end
  end
end
