require_relative '../../spec_helper'
require 'soundcheck/project'
require 'soundcheck/frameworks'

describe "Frameworks" do
  let(:project) { Project.new(fixture("null-project")) }

  describe "Minitest" do
    let(:framework) { Frameworks::Minitest.new(project) }

    it "should find the minitest framework" do
      project.stub!(:root => fixture("ruby-minitest"))
      framework.present?.should be_true
    end
    
    it "should not find when not there" do
      framework.present?.should be_false
    end

    it "should work with no args" do
      framework.command().should == "rake test"
    end

    it "should not do anything when args contain no cutest files" do
      framework.command("features/a.feature").should == nil
    end

    it "should work with multiple args" do
      cmd = framework.command("test/a_test.rb", "test/b_test.rb")
      cmd.should == "rake test"
    end

    it "should work with a single arg" do
      cmd = framework.command("test/a_test.rb")
      cmd.should == "rake test TEST=test/a_test.rb"
    end

    it "should filter invalid non-cutest args" do
      cmd = framework.command("test/a_test.rb", "features/a.feature")
      cmd.should == "rake test TEST=test/a_test.rb"
    end
  end
end


