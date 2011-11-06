require_relative '../../spec_helper'
require 'soundcheck/project'
require 'soundcheck/frameworks'

describe "Frameworks" do
  let(:project) { Project.new(fixture("null-project")) }

  describe "Expresso" do
    let(:framework) { Frameworks::Expresso.new(project) }

    it "should find the expresso framework" do
      project.stub(:root => fixture("node-expresso"))
      framework.present?.should be_true
    end

    it "should not find when not there" do
      project.stub(:root => fixture("null-project"))
      framework.present?.should be_false
    end

    it "should run with no args" do
      framework.command.should == "expresso --include lib test/*"
    end

    it "should not run when args contain no expresso files" do
      framework.command("spec/foo_spec.rb").should == nil
    end

    it "should run with args" do
      framework.command("test/foo.js").should == "expresso --include lib test/foo.js"
    end
  end
end
