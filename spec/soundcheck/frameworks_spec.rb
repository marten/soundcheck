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

    
  end

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
  end
end
