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

    logger.level = Logger::DEBUG if options[:verbose]
    logger.debug "Debug logging enabled."
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
end
