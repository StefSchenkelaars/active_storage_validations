# frozen_string_literal: true

require 'test_helper'
require_relative './helpers/dummy_file_helpers'

module ActiveStorageValidations
  class AspectRatioValidator
    class Test < ActiveSupport::TestCase
      include DummyFileHelpers

      test 'aspect ratio validation' do
        e = RatioModel.new(name: 'Princess Leia')
        e.ratio_one.attach(image_150x150_file)
        e.ratio_many.attach([image_600x800_file])
        e.save!

        e = RatioModel.new(name: 'Princess Leia')
        e.ratio_one.attach(image_150x150_file)
        e.ratio_many.attach([image_150x150_file])
        e.save
        assert !e.valid?
        assert_equal e.errors.full_messages, ['Ratio many must be a portrait image']

        e = RatioModel.new(name: 'Princess Leia')
        e.ratio_one.attach(image_150x150_file)
        e.ratio_many.attach([image_600x800_file])
        e.image1.attach(image_150x150_file)
        assert !e.valid?
        assert_equal e.errors.full_messages, ['Image1 must have an aspect ratio of 16x9']

        e = RatioModel.new(name: 'Princess Leia')
        e.ratio_one.attach(html_file)
        e.ratio_many.attach([image_600x800_file])
        e.image1.attach(image_1920x1080_file)
        assert !e.valid?
        assert_equal e.errors.full_messages, ['Ratio one is not a valid image']
      end
    end
  end
end
