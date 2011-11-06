require 'soundcheck/logging'
require 'soundcheck/languages'

class Project
  class UnknownLanguage < StandardError; end

  attr_accessor :root

  def initialize(root)
    self.root = root
  end

  def has_dir?(dirname)
    Dir.chdir(root) do
      Dir.exist?(dirname)
    end
  end

  def has_file?(filename)
    Dir.chdir(root) do
      not Dir.glob(filename).empty?
    end
  end

  def has_files?(*paths)
    paths.any? { |path| has_file?(path) }
  end

  def language
    case
    when has_file?("Gemfile")
      logger.debug "You have a Gemfile, so I think this is Ruby."
      return Languages::Ruby.new(self) 
    when has_file?("Rakefile")
      logger.debug "You have a Rakefile, so I think this is Ruby."
      return Languages::Ruby.new(self) 
    when has_file?("*.gemspec")
      logger.debug "You have a gemspec, so I think this is Ruby."
      return Languages::Ruby.new(self) 
    when has_file?("package.json")
      logger.debug "You have a package.json, so I think this is NodeJS."
      return Languages::NodeJS.new(self) 
    else
      raise UnknownLanguage
    end
  end
  
  def frameworks
    detected_frameworks = language.frameworks.map do |framework_class|
      framework_class.new(self)
    end
    logger.debug "Detected your frameworks: #{detected_frameworks}"
    return detected_frameworks
  end

  def execute(command)
    logger.debug "Executing #{command}"
    Dir.chdir(root) do
      output = `#{command}`
      [output, $?]
    end
  end
end
