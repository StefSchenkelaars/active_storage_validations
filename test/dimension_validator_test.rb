# frozen_string_literal: true

require 'test_helper'
require_relative './helpers/dummy_file_helpers'

module ActiveStorageValidations
  class DimensionValidator
    class Test < ActiveSupport::TestCase
      include DummyFileHelpers

      test 'dimensions and is image' do
        e = OnlyImage.new
        e.image.attach(html_file)
        assert !e.valid?
        assert_equal e.errors.full_messages, ['Image is not a valid image', 'Image has an invalid content type']

        e = OnlyImage.new
        e.image.attach(image_1920x1080_file)
        assert e.valid?

        e = OnlyImage.new
        e.image.attach(pdf_file)
        assert !e.valid?
        assert e.errors.full_messages.include?('Image has an invalid content type')
      rescue StandardError => e
        puts e.message
        puts e.backtrace.take(20).join("\n")
        raise e
      end

      test 'dimensions test' do
        e = Project.new(title: 'Death Star')
        e.preview.attach(big_file)
        e.small_file.attach(dummy_file)
        e.attachment.attach(pdf_file)
        e.dimension_exact.attach(html_file)
        assert !e.valid?
        assert_equal e.errors.full_messages, ['Dimension exact is not a valid image']

        e = Project.new(title: 'Death Star')
        e.preview.attach(big_file)
        e.small_file.attach(dummy_file)
        e.attachment.attach(pdf_file)
        e.documents.attach(pdf_file)
        e.documents.attach(pdf_file)
        e.valid?
        assert e.valid?

        e = Project.new(title: 'Death Star')
        e.preview.attach(big_file)
        e.small_file.attach(dummy_file)
        e.attachment.attach(pdf_file)
        e.dimension_exact.attach(image_150x150_file)
        assert e.valid?, 'Dimension exact: width and height must be equal to 150 x 150 pixel.'

        e = Project.new(title: 'Death Star')
        e.preview.attach(big_file)
        e.small_file.attach(dummy_file)
        e.attachment.attach(pdf_file)
        e.dimension_range.attach(image_800x600_file)
        assert e.valid?, 'Dimension range: width and height must be greater than or equal to 800 x 600 pixel.'

        e = Project.new(title: 'Death Star')
        e.preview.attach(big_file)
        e.small_file.attach(dummy_file)
        e.attachment.attach(pdf_file)
        e.dimension_range.attach(image_1200x900_file)
        assert e.valid?, 'Dimension range: width and height must be less than or equal to 1200 x 900 pixel.'

        e = Project.new(title: 'Death Star')
        e.preview.attach(big_file)
        e.small_file.attach(dummy_file)
        e.attachment.attach(pdf_file)
        e.dimension_min.attach(image_800x600_file)
        assert e.valid?, 'Dimension min: width and height must be greater than or equal to 800 x 600 pixel.'

        e = Project.new(title: 'Death Star')
        e.preview.attach(big_file)
        e.small_file.attach(dummy_file)
        e.attachment.attach(pdf_file)
        e.dimension_max.attach(image_1200x900_file)
        assert e.valid?, 'Dimension max: width and height must be greater than or equal to 1200 x 900 pixel.'

        e = Project.new(title: 'Death Star')
        e.preview.attach(big_file)
        e.small_file.attach(dummy_file)
        e.attachment.attach(pdf_file)
        e.dimension_images.attach([image_800x600_file, image_1200x900_file])
        assert e.valid?, 'Dimension many: width and height must be between or equal to 800 x 600 and 1200 x 900 pixel.'

        e = Project.new(title: 'Death Star')
        e.preview.attach(big_file)
        e.small_file.attach(dummy_file)
        e.attachment.attach(pdf_file)
        e.dimension_images.attach([image_800x600_file])
        e.save!
        e.dimension_images.attach([image_800x600_file])

        e.title = 'Changed'
        e.save!
        e.reload
        assert e.title, 'Changed'

        assert_nil e.dimension_min.attachment
        blob = ActiveStorage::Blob.create_after_upload!(**image_800x600_file)
        e.dimension_min = blob.signed_id
        e.save!
        e.reload
        assert_not_nil e.dimension_min.attachment
        assert_not_nil e.dimension_min.blob.signed_id
      rescue StandardError => e
        puts e.message
        puts e.backtrace.join("\n")
        raise e
      end
    end
  end
end
