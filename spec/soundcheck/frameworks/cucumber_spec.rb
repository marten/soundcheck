require_relative '../../spec_helper'
require 'soundcheck/project'
require 'soundcheck/frameworks'

describe "Frameworks" do
  let(:project) { Project.new(fixture("null-project")) }

  describe "Cucumber" do
    let(:framework) { Frameworks::Cucumber.new(project) }

    it "should find the cucumber framework" do
      project.stub!(:root => fixture("ruby-cucumber"))
      framework.present?.should be_true
    end
    
    it "should not find when not there" do
      project.stub(:root => fixture("null-project"))
      framework.present?.should be_false
    end

    it "should run with no args" do
      framework.command.should == "cucumber features"
    end

    it "should not run when args contain no cucumber files" do
      framework.command("spec/foo_spec.rb").should == nil
    end

    it "should run with args" do
      framework.command("features/a.feature").should == "cucumber features/a.feature"
    end
  end
end
