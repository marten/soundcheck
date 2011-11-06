require_relative '../spec_helper'
require 'soundcheck/project'
require 'soundcheck/frameworks'

describe "Frameworks" do
  let(:project) { Project.new(fixture("null-project")) }

  describe "Base" do
    let(:framework) do
      framework = Class.new
      framework.instance_eval { include Frameworks::Base }
      framework.new(stub)
    end

    describe "#filter_with" do
      it "should filter with regexes" do
        framework.filter_with(["asdf", "aoeu", "qwer"],
                              {:begins_with_a => /^a/}).should == ["asdf", "aoeu"]
        framework.filter_with(["asdf", "aoeu", "qwer", "1234"],
                              {:begins_with_a => /^a/,
                               :contains_r    => /r/}).should == ["asdf", "aoeu", "qwer"]
      end

      it "should filter with lambdas" do
        framework.filter_with(["a", "b"], {:equals_a => lambda {|arg| arg == "a"}}).should == ["a"]
      end

      it "should raise when given unknown filter type" do
        expect do
          framework.filter_with(["a"], {:unknown => nil})
        end.to raise_error
      end
    end
  end
end
