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

    module InstanceMethods
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

  class RSpec
    include Frameworks::Base

    def present?
      project.has_file?("spec")
    end

    def filter(*args)
      filter_with(args, {
        :is_spec_file   => /_spec\.rb$/,
        :is_in_spec_dir => /^spec/,
        :is_dir         => lambda {|arg| project.has_dir?(arg) }
      })
    end
    
    def default_args
      ["spec"]
    end

    def command(*args)
      args = (args.empty? ? default_args : filter(*args))
      return nil if args.empty?

      to_run = []
      to_run << "bundle exec" if has_gemfile? and requires_spec_helper?(*args)
      to_run << "rspec"
      to_run << "-b" if options[:trace]
      to_run << args.join(" ")
      to_run.join(" ").strip
    end

    private

    def requires_spec_helper?(*args)
      output, status = project.execute("grep -r 'spec_helper' #{args.join(" ")}")
      status.exitstatus == 0 # matched
    end

    def has_gemfile?
      project.has_file?("Gemfile")
    end
  end

  class Cucumber
    include Frameworks::Base

    def present?
      project.has_file?("features")
    end

    def filter(*args)
      args.select { |arg| arg =~ /\.feature$/ }
    end

    def default_args
      ["features"]
    end

    def command(*args)
      args = (args.empty? ? default_args : filter(*args))
      return nil if args.empty?

      to_run = []
      to_run << "bundle exec" if has_gemfile?
      to_run << "cucumber #{args.join(" ")}".strip
      to_run.join(" ")
    end

    private

    def requires_spec_helper?(*args)
      output, status = project.execute("grep -r 'spec_helper' #{args.join(" ")}")
      status.exitstatus == 0 # matched
    end

    def has_gemfile?
      project.has_file?("Gemfile")
    end
  end

  class RubyCutest
    include Frameworks::Base

    def present?
      project.has_file?("Rakefile") and project.file_contents("Rakefile") =~ /Cutest\.run/
    end

    def filter(*args)
      filter_with(args, {
        :is_in_test_dir => /^test\//
      })
    end

    def default_args
      ["test/*.rb"]
    end

    def command(*args)
      args = (args.empty? ? default_args : filter(*args))
      return nil if args.empty?

      "cutest #{args.join(" ")}".strip
    end
  end

  class Expresso
    include Frameworks::Base

    def present?
      project.has_file?("test/*.js")
    end

    def filter(*args)
      filter_with(args, {
        :is_js_file => /\.js$/
      })
    end

    def default_args
      ["test/*"]
    end

    def command(*args)
      args = (args.empty? ? default_args : filter(*args))
      return nil if args.empty?

      "expresso --include lib #{args.join(" ")}"
    end
  end
end
