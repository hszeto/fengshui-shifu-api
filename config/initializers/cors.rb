# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Allow all origins for dev / mobile client connection
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head]
  end
end
