require_relative '../../spec_helper'
require 'soundcheck/project'
require 'soundcheck/frameworks'

describe "Frameworks" do
  let(:project) { Project.new(fixture("null-project")) }

  describe "Ruby Cutest" do
    # This is for the Ruby library called Cutest,
    # not the C Unit Testing library called CuTest
    #
    # https://github.com/djanowski/cutest
    
    let(:framework) { Frameworks::RubyCutest.new(project) }

    it "should find the rspec framework" do
      project.stub!(:root => fixture("ruby-cutest"))
      framework.present?.should be_true
    end
    
    it "should not find when not there" do
      framework.present?.should be_false
    end

    it "should work with no args" do
      framework.command().should == "cutest test/*.rb"
    end

    it "should not do anything when args contain no cutest files" do
      framework.command("features/a.feature").should == nil
    end

    it "should work with args" do
      cmd = framework.command("test/a.rb", "test/b.rb")
      cmd.should == "cutest test/a.rb test/b.rb"
    end

    it "should filter invalid non-cutest args" do
      cmd = framework.command("test/a.rb", "features/a.feature")
      cmd.should == "cutest test/a.rb"
    end
  end
end

