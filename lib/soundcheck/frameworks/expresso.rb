module Frameworks
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

      local_expresso = "node_modules/expresso/bin/expresso"
      expresso_bin = project.has_file?(local_expresso) ? local_expresso : "expresso"

      "#{expresso_bin} --include lib #{args.join(" ")}"
    end
  end
end
