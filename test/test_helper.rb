# frozen_string_literal: true

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

# Load dummy rails application with combustion gem
require 'combustion'
Combustion.path = 'test/dummy'
Combustion.initialize! :active_record, :active_storage, :active_job do
  config.active_job.queue_adapter = :inline if Rails::VERSION::MAJOR >= 6
end

# Load other test helpers
require 'rails/test_help'
require 'minitest/mock'

puts "Running tests with Rails v.#{Rails.version}"
