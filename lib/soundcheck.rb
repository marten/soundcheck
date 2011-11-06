require 'soundcheck/logging'
require 'soundcheck/project'

class Soundcheck
  attr_accessor :project
  attr_accessor :paths
  attr_accessor :options

  def initialize(paths, options = {})
    self.project = Project.new(Dir.pwd)
    self.paths = paths
    self.options = options

    logger.level = Logger::DEBUG if options[:verbose]
    logger.debug "Debug logging enabled."
  end

  def command_to_run
    project.frameworks.each do |framework|
      framework.options = options
      command = framework.command(*paths)
      return command if command
    end
  end
end
