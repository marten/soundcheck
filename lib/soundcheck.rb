require 'soundcheck/logging'
require 'soundcheck/project'

class Soundcheck
  attr_accessor :project
  attr_accessor :path
  attr_accessor :options

  def initialize(path = "spec", options = {})
    self.project = Project.new(Dir.pwd)
    self.path = path
    self.options = options
  end

  def command_to_run
    commands = []
    project.frameworks.each do |framework|
      framework.options = options
      command = framework.command(*path)
      commands << command if command
    end
    commands.first
  end

  def requires_spec_helper?
    `grep -r 'spec_helper' #{@path}`
    $?.exitstatus == 0 # matched
  end

  def has_gemfile?
    File.exist?("Gemfile")
  end
end
