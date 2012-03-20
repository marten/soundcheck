require 'active_support/deprecation'
require 'active_support/concern'
require 'soundcheck/frameworks'

module Languages
  module Base
    extend ActiveSupport::Concern

    included do
      attr_accessor(:project)

      define_method(:initialize) do |project|
        self.project = project
      end
    end

    def frameworks
      known_frameworks.select do |framework|
        framework.new(project).present?
      end
    end
  end

  class Ruby
    include Base
    
    def known_frameworks
      [ Frameworks::RSpec, Frameworks::Cucumber, Frameworks::Minitest, Frameworks::RubyCutest ]
    end
  end

  class NodeJS
    include Base

    def known_frameworks
      [ Frameworks::Expresso ]
    end
  end
end
