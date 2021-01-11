# frozen_string_literal: true

require 'test_helper'
require_relative './helpers/dummy_file_helpers'

module ActiveStorageValidations
  class LimitValidator
    class Test < ActiveSupport::TestCase
      include DummyFileHelpers

      test 'validates number of files' do
        e = Project.new(title: 'Death Star')
        e.preview.attach(big_file)
        e.small_file.attach(dummy_file)
        e.attachment.attach(pdf_file)
        e.documents.attach(pdf_file)
        e.documents.attach(pdf_file)
        e.documents.attach(pdf_file)
        e.documents.attach(pdf_file)
        assert !e.valid?
        assert_equal e.errors.full_messages, ['Documents total number is out of range']
      end

      test 'validates number of files for Rails 6' do
        la = LimitAttachment.create(name: 'klingon')
        la.files.attach([pdf_file, pdf_file, pdf_file, pdf_file, pdf_file, pdf_file])

        assert !la.valid?

        assert_equal 6, la.files.count

        if Rails.version < '6.0.0'
          assert_equal 6, la.files_blobs.count
        else
          assert_equal 0, la.files_blobs.count
        end

        assert_equal ['Files total number is out of range'], la.errors.full_messages

        if Rails.version < '6.0.0'
          la.files.first.purge
          la.files.first.purge
          la.files.first.purge
          la.files.first.purge
        end

        assert !la.valid?
        assert_equal ['Files total number is out of range'], la.errors.full_messages
      end

      test 'validates number of files v2' do
        la = LimitAttachment.create(name: 'klingon')
        la.files.attach([pdf_file, pdf_file, pdf_file])

        assert la.valid?
        assert_equal 3, la.files.count
        assert la.save
        la.reload

        assert_equal 3, la.files_blobs.count
        la.files.first.purge

        assert la.valid?
        la.reload
        assert_equal 2, la.files_blobs.count
      end

      test 'validates number of files v3' do
        la = LimitAttachment.create(name: 'klingon')
        la.files.attach([pdf_file, pdf_file, pdf_file, pdf_file, pdf_file])

        assert !la.valid?
        assert_equal 5, la.files.count
        assert !la.save
      end
    end
  end
end
