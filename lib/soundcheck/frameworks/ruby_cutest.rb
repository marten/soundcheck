module Frameworks
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
end
