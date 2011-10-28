class Soundcheck
  attr_accessor :path

  def initialize(path = "spec")
    @path = path
  end

  def command_to_run
    if requires_spec_helper?
      "rspec #{@path}"
    else
      "bundle exec rspec #{@path}"
    end
  end

  def requires_spec_helper?
    `grep -r 'spec_helper' #{@path}`
    $?.exitstatus == 1 # no match; we have a stand-alone spec
  end
end
