require 'logger'

def logger
  return $logger if $logger
  $logger = Logger.new(STDOUT)
  $logger.level = Logger::INFO
  $logger
end
