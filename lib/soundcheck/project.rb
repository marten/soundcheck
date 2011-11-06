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
    return Languages::Ruby.new(self)   if has_file?("Gemfile")
    return Languages::Ruby.new(self)   if has_file?("spec/*.rb")
    return Languages::NodeJS.new(self) if has_file?("package.json")
    raise UnknownLanguage
  end
  
  def frameworks
    language.frameworks.map do |framework_class|
      framework_class.new(self)
    end
  end

  def execute(command)
    logger.debug "Executing #{command}"
    Dir.chdir(root) do
      output = `#{command}`
      [output, $?]
    end
  end
end
