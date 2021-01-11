# frozen_string_literal: true

require 'test_helper'
require_relative './helpers/dummy_file_helpers'

module ActiveStorageValidations
  class AttachedValidator
    class Test < ActiveSupport::TestCase
      include DummyFileHelpers

      test 'validates presence' do
        u = User.new(name: 'John Smith')
        assert !u.valid?
        assert_equal u.errors.full_messages, ["Avatar can't be blank", "Photos can't be blank"]

        u = User.new(name: 'John Smith')
        u.avatar.attach(dummy_file)
        assert !u.valid?
        assert_equal u.errors.full_messages, ["Photos can't be blank"]

        u = User.new(name: 'John Smith')
        u.photos.attach(dummy_file)
        assert !u.valid?
        assert_equal u.errors.full_messages, ["Avatar can't be blank"]
      end
    end
  end
end
