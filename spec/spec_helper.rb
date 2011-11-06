FIXTURES_ROOT = File.expand_path(File.dirname(__FILE__) + '/../fixtures')

require 'soundcheck/logging'
logger.level = Logger::WARN

def fixture(name)
  File.join(FIXTURES_ROOT, name)
end
