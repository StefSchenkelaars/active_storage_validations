# frozen_string_literal: true

require 'test_helper'
require_relative './helpers/dummy_file_helpers'

module ActiveStorageValidations
  class ContentTypeValidator
    class Test < ActiveSupport::TestCase
      include DummyFileHelpers

      test 'validates content type' do
        u = User.new(name: 'John Smith')
        u.avatar.attach(dummy_file)
        u.image_regex.attach(dummy_file)
        u.photos.attach(bad_dummy_file)
        assert !u.valid?
        assert_equal u.errors.full_messages, ['Photos has an invalid content type']

        u = User.new(name: 'John Smith')
        u.avatar.attach(bad_dummy_file)
        u.image_regex.attach(dummy_file)
        u.photos.attach(dummy_file)
        assert !u.valid?
        assert_equal u.errors.full_messages, ['Avatar has an invalid content type']
        assert_equal u.errors.details, avatar: [
          {
            error: :content_type_invalid,
            authorized_types: 'PNG',
            content_type: 'text/plain'
          }
        ]

        u = User.new(name: 'John Smith')
        u.avatar.attach(dummy_file)
        u.image_regex.attach(bad_dummy_file)
        u.photos.attach(dummy_file)
        assert !u.valid?
        assert_equal u.errors.full_messages, ['Image regex has an invalid content type']

        u = User.new(name: 'John Smith')
        u.avatar.attach(bad_dummy_file)
        u.image_regex.attach(bad_dummy_file)
        u.photos.attach(bad_dummy_file)
        assert !u.valid?
        assert_equal u.errors.full_messages,
                     ['Avatar has an invalid content type', 'Photos has an invalid content type',
                      'Image regex has an invalid content type']
      end

      # reads content type from file, not from webp_file_wrong method
      test 'webp content type 1' do
        u = User.new(name: 'John Smith')
        u.avatar.attach(webp_file_wrong)
        u.image_regex.attach(webp_file_wrong)
        u.photos.attach(webp_file_wrong)
        assert !u.valid?
        assert_equal u.errors.full_messages,
                     ['Avatar has an invalid content type', 'Photos has an invalid content type']
      end

      # trying to attache webp file with PNG extension, but real content type is detected
      test 'webp content type 2' do
        u = User.new(name: 'John Smith')
        u.avatar.attach(webp_file)
        u.image_regex.attach(webp_file)
        u.photos.attach(webp_file)
        assert !u.valid?
        assert_equal u.errors.full_messages,
                     ['Avatar has an invalid content type', 'Photos has an invalid content type']
      end
    end
  end
end
