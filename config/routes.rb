# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'health', to: 'health#show'
      post 'bazi/calculate', to: 'bazi#calculate'
    end
  end
end
