# frozen_string_literal: true

require 'test_helper'
require_relative './helpers/dummy_file_helpers'

module ActiveStorageValidations
  class SizeValidator
    class Test < ActiveSupport::TestCase
      include DummyFileHelpers

      test 'validates size' do
        e = Project.new(title: 'Death Star')
        e.preview.attach(big_file)
        e.small_file.attach(big_file)
        e.attachment.attach(pdf_file)
        assert !e.valid?
        assert_equal e.errors.full_messages, ['Small file size 1.6 KB is not between required range']
      end
    end
  end
end
