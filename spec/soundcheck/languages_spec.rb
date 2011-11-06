require_relative "../spec_helper"
require 'soundcheck/languages'

describe "Languages" do
  describe "Base" do
    let(:language) do
      language = Class.new
      language.instance_eval { include(Languages::Base) }
      language.new(stub)
    end

    describe "#frameworks" do
      it "should ask known frameworks for presence" do
        framework_instance = stub
        framework = stub(:new => framework_instance)
        language.stub(:known_frameworks => [framework])

        framework_instance.should_receive(:present?)
        language.frameworks
      end
    end
  end
end
