require_relative '../../spec_helper'
require 'soundcheck/project'
require 'soundcheck/frameworks'

describe "Frameworks" do
  let(:project) { Project.new(fixture("null-project")) }

  describe "RSpec" do
    let(:framework) { Frameworks::RSpec.new(project) }

    it "should find the rspec framework" do
      project.stub!(:root => fixture("ruby-rspec"))
      framework.present?.should be_true
    end
    
    it "should not find when not there" do
      framework.present?.should be_false
    end

    it "should work with no args" do
      framework.command().should == "rspec spec"
    end

    it "should not do anything when args contain no spec files" do
      framework.command("features/a.feature").should == nil
    end

    it "should require spec helper" do
      project.stub!(:root => fixture("ruby-bundler-rspec"))
      framework.command.should == "bundle exec rspec spec"
    end

    it "should not use bundler when not needed" do
      project.stub!(:root => fixture("ruby-bundler-rspec"))
      cmd = framework.command("spec/without_spec_helper_spec.rb")
      cmd.should == "rspec spec/without_spec_helper_spec.rb"
    end

    it "should show backtraces when requested" do
      framework.options[:trace] = true
      framework.command("spec/a_spec.rb").should == "rspec -b spec/a_spec.rb"
    end

    it "should only run fast specs when requested" do pending
      project.stub!(:root => fixture("ruby-bundler-rspec"))
      framework.options[:fast] = true
     
      # Old implementation:
      #
      # if options[:fast]
      #   @path = `grep -r -L 'spec_helper' #{path || "spec"} | grep '_spec.rb'`.strip.gsub("\n", " ")
    end


    it "should work with args" do
      cmd = framework.command("spec/a_spec.rb", "spec/b_spec.rb")
      cmd.should == "rspec spec/a_spec.rb spec/b_spec.rb"
    end

    it "should filter invalid non-spec args" do
      cmd = framework.command("spec/a_spec.rb", "features/a.feature")
      cmd.should == "rspec spec/a_spec.rb"
    end
  end
end
