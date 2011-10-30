class Soundcheck
  attr_accessor :path

  def initialize(path = "spec", options = {})
    @options = options

    if options[:fast]
      @path = `grep -r -L 'spec_helper' #{path || "spec"} | grep '_spec.rb'`.strip.gsub("\n", " ")
    else
      @path = path || "spec"
    end
  end

  def command_to_run
    if has_gemfile?
      if requires_spec_helper?
        return "rspec --drb #{@path}"
      else
        return "bundle exec rspec --drb #{@path}"
      end
    end

    # Assume rspec
    "rspec --drb #{@path}"
  end

  def requires_spec_helper?
    `grep -r 'spec_helper' #{@path}`
    $?.exitstatus == 1 # no match; we have a stand-alone spec
  end

  def has_gemfile?
    File.exist?("Gemfile")
  end
end
