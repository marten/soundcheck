module Frameworks
  class Minitest
    include Frameworks::Base

    def present?
      project.has_file?("test")
    end

    def filter(*args)
      filter_with(args, {
        :is_test_file   => /_test\.rb$/,
        :is_in_test_dir => /^test/,
        :is_dir         => lambda {|arg| project.has_dir?(arg) }
      })
    end

    def command(*args)
      # If we were given args, but none of them are minitest files, 
      # then we skip minitest
      return if not args.empty? and filter(*args).empty?
      args = filter(*args)

      # rake test can either run a single file, or all of them,
      # so if we're given more than one, just run all
      args = [] if args.length > 1
      args = args.map {|i| "TEST=#{i}" }

      to_run = []
      to_run << "bundle exec" if has_gemfile?
      to_run << "rake test"
      to_run << "-t" if options[:trace]
      to_run << args.join(" ")
      to_run.join(" ").strip
    end

    private

    def has_gemfile?
      project.has_file?("Gemfile")
    end
  end
end

