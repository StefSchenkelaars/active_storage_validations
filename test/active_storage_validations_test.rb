# frozen_string_literal: true

require 'test_helper'

module ActiveStorageValidations
  class Test < ActiveSupport::TestCase
    test 'truth' do
      assert_kind_of Module, ActiveStorageValidations
    end
  end
end
