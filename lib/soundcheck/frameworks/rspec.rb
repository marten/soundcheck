module Frameworks
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
      to_run << executable
      to_run << "-b" if options[:trace]
      to_run << "--format=doc" if args.size < 2 and args != default_args
      to_run << args.join(" ")
      to_run.join(" ").strip
    end

    private

    def executable
      if has_binstub?
        "bin/rspec"
      elsif has_gemfile?
        "bundle exec rspec"
      else
        "rspec"
      end
    end

    def requires_spec_helper?(*args)
      output, status = project.execute("grep -r 'spec_helper' #{args.join(" ")}")
      status.exitstatus == 0 # matched
    end

    def has_binstub?
      project.has_file?('bin/rspec')
    end

    def has_gemfile?
      project.has_file?("Gemfile")
    end
  end
end
