# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaziCalculatorService do
  describe '#calculate' do
    it 'correctly calculates Day Master for January 1, 1990 (Male)' do
      result = described_class.new(birth_date: '1990-01-01', gender: 'male').calculate

      expect(result[:day_master][:name]).to eq('Ren Water')
      expect(result[:day_master][:chinese]).to eq('壬水')
      expect(result[:day_master][:element]).to eq('Water')
      expect(result[:kua_number]).to eq(7)
      expect(result[:kua_profile][:sheng_qi]).to eq('NW')
    end
  end
end
