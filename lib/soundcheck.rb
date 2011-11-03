class Soundcheck
  attr_accessor :path

  def initialize(path = "spec", options = {})
    @options = options

    if options[:fast]
      @path = `grep -r -L 'spec_helper' #{path || "spec"} | grep '_spec.rb'`.strip.gsub("\n", " ")
    else
      @path = path || "spec"
    end

    if @path.empty?
      puts "Error: No specs to run."
      exit 1
    end
  end

  def command_to_run
    prefix = (has_gemfile? and requires_spec_helper?) ? "bundle exec" : ""
    args   = []
    args  << "-b" if @options[:trace]

    [prefix, "rspec", *args, @path].join(" ")
  end

  def requires_spec_helper?
    `grep -r 'spec_helper' #{@path}`
    $?.exitstatus == 0 # matched
  end

  def has_gemfile?
    File.exist?("Gemfile")
  end
end
