# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaziCalculatorService do
  describe '#calculate' do
    it 'correctly calculates Day Master for January 1, 1990 (Male)' do
      result = described_class.new(birth_date: '1990-01-01', gender: 'male').calculate

      expect(result[:day_master][:name]).to eq('Ren Water')
      expect(result[:day_master][:chinese]).to eq('壬水')
      expect(result[:day_master][:element]).to eq('Water')
      expect(result[:kua_number]).to eq(1)
      expect(result[:kua_profile][:sheng_qi]).to eq('SE')
      expect(result[:birth_time]).to be_nil
      expect(result[:hour_branch]).to be_nil
    end

    it 'calculates hour branch when birth_time is provided (12:34 => Wu Horse)' do
      result = described_class.new(birth_date: '1990-01-01', gender: 'male', birth_time: '12:34').calculate

      expect(result[:birth_time]).to eq('12:34')
      expect(result[:hour_branch][:name]).to eq('Wu Horse')
      expect(result[:hour_branch][:animal]).to eq('Horse')
    end

    it 'handles unspecified gender gracefully' do
      result = described_class.new(birth_date: '1990-01-01').calculate

      expect(result[:gender]).to eq('unspecified')
      expect(result[:kua_number]).to eq(nil)
    end
  end
end
