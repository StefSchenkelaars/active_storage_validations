# frozen_string_literal: true

require 'test_helper'
require 'active_storage_validations/matchers'

module ActiveStorageValidations
  module Matchers
    class SizeValidatorMatcher
      class Test < ActiveSupport::TestCase
        test 'positive match greater than' do
          matcher = ActiveStorageValidations::Matchers::SizeValidatorMatcher.new(:preview)
          matcher.greater_than 1.kilobyte
          assert matcher.matches?(Project)
        end

        test 'higher than greater than' do
          matcher = ActiveStorageValidations::Matchers::SizeValidatorMatcher.new(:preview)
          matcher.greater_than 2.kilobyte
          refute matcher.matches?(Project)
        end

        test 'lower than greater than' do
          matcher = ActiveStorageValidations::Matchers::SizeValidatorMatcher.new(:preview)
          matcher.greater_than 0.5.kilobyte
          refute matcher.matches?(Project)
        end

        test 'positive match between' do
          matcher = ActiveStorageValidations::Matchers::SizeValidatorMatcher.new(:attachment)
          matcher.between 0..500.kilobytes
          assert matcher.matches?(Project)
        end

        test 'low too high match between' do
          matcher = ActiveStorageValidations::Matchers::SizeValidatorMatcher.new(:attachment)
          matcher.between 100..500.kilobytes
          refute matcher.matches?(Project)
        end

        test 'high too high match between' do
          matcher = ActiveStorageValidations::Matchers::SizeValidatorMatcher.new(:attachment)
          matcher.between 0..600.kilobytes
          refute matcher.matches?(Project)
        end

        test 'high too low match between' do
          matcher = ActiveStorageValidations::Matchers::SizeValidatorMatcher.new(:attachment)
          matcher.between 0..400.kilobytes
          refute matcher.matches?(Project)
        end

        test 'positive match less than' do
          matcher = ActiveStorageValidations::Matchers::SizeValidatorMatcher.new(:small_file)
          matcher.less_than 1.kilobyte
          assert matcher.matches?(Project)
        end

        test 'higher than less than' do
          matcher = ActiveStorageValidations::Matchers::SizeValidatorMatcher.new(:small_file)
          matcher.less_than 2.kilobyte
          refute matcher.matches?(Project)
        end

        test 'lower than less than' do
          matcher = ActiveStorageValidations::Matchers::SizeValidatorMatcher.new(:small_file)
          matcher.less_than 0.5.kilobyte
          refute matcher.matches?(Project)
        end

        test 'works when providing an instance' do
          matcher = ActiveStorageValidations::Matchers::SizeValidatorMatcher.new(:preview)
          matcher.greater_than 1.kilobyte
          assert matcher.matches?(Project.new)
        end

        test 'unkown attached when providing class' do
          matcher = ActiveStorageValidations::Matchers::SizeValidatorMatcher.new(:non_existing)
          matcher.greater_than 1.kilobyte
          refute matcher.matches?(Project)
        end

        test 'unkown attached when providing instance' do
          matcher = ActiveStorageValidations::Matchers::SizeValidatorMatcher.new(:non_existing)
          matcher.greater_than 1.kilobyte
          refute matcher.matches?(Project.new)
        end
      end
    end
  end
end
