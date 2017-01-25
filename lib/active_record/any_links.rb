require 'active_record'
require 'active_record/any_links/version'
require 'active_record/any_links/class_methods'

module ActiveRecord
  class Base
    # include AnyLinks
    extend AnyLinks::ClassMethods
  end
end
