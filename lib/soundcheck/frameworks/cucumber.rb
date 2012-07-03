module Frameworks
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

    def has_gemfile?
      project.has_file?("Gemfile")
    end
  end
end
