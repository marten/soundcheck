require 'active_support/deprecation'
require 'active_support/concern'
require 'soundcheck/logging'

module Frameworks
  module Base
    extend ActiveSupport::Concern

    included do
      attr_accessor :project
      attr_accessor :options

      define_method :initialize do |project|
        self.project = project
        self.options = {}
      end
    end

    def filter_with(args, filters)
      logger.debug "Filtering #{args.inspect}"
      args.select do |arg|
        filters.any? do |key, value|
          case value
          when Regexp
            arg =~ value
          when Proc
            value.call(arg)
          else
            raise "Unknown filter type for #{value}"
          end
        end
      end
    end

    def to_s
      self.class.name.split("::").last
    end
  end
end

Dir[File.join(File.expand_path(File.dirname(__FILE__)), 'frameworks/*.rb')].each {|f| require f}
