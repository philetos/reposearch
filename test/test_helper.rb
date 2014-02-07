ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  fixtures :all

  include FactoryGirl::Syntax::Methods

  # Get shoulda-context working in Rails 4
  include Shoulda::Context::Assertions
  include Shoulda::Context::InstanceMethods
  extend Shoulda::Context::ClassMethods

  # Get shoulda-matchers (for AR) working in Rails 4
  include Shoulda::Matchers::ActiveRecord
  extend Shoulda::Matchers::ActiveRecord
  include Shoulda::Matchers::ActiveModel
  extend Shoulda::Matchers::ActiveModel

  # Override shoulda-context
  #
  # Should be fixed in Rails 4
  def assert_accepts(matcher, target, options = {})
    if matcher.respond_to?(:in_context)
      matcher.in_context(self)
    end

    if matcher.matches?(target)
      assert true
      if options[:message]
        assert_match options[:message], matcher.negative_failure_message
      end
    else
      assert false, matcher.failure_message
    end
  end

  # Override shoulda-context
  #
  # Should be fixed in Rails 4
  def assert_rejects(matcher, target, options = {})
    if matcher.respond_to?(:in_context)
      matcher.in_context(self)
    end

    not_match = matcher.respond_to?(:does_not_match?) ? matcher.does_not_match?(target) : !matcher.matches?(target)

    if not_match
      assert true

      if options[:message]
        assert_match options[:message], matcher.failure_message
      end
    else
      assert false, matcher.failure_message
    end
  end
end
