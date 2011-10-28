class Soundcheck
  attr_accessor :path

  def initialize(path = "spec")
    @path = path || "spec"
  end

  def command_to_run
    if has_gemfile?
      if requires_spec_helper?
        return "rspec #{@path}"
      else
        return "bundle exec rspec #{@path}"
      end
    end

    # Assume rspec
    "rspec #{@path}"
  end

  def requires_spec_helper?
    `grep -r 'spec_helper' #{@path}`
    $?.exitstatus == 1 # no match; we have a stand-alone spec
  end

  def has_gemfile?
    File.exist?("Gemfile")
  end
end
