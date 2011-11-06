require_relative "../spec_helper"
require "soundcheck/project"

describe Project do
  it "should be initialized" do
    project = Project.new(fixture("ruby-rspec"))
    project.root.should == fixture("ruby-rspec")
  end

  it "should determine the language used" do
    Project.new(fixture("ruby-rspec")).language.should be_a(Languages::Ruby)
    Project.new(fixture("node-expresso")).language.should be_a(Languages::NodeJS)

    expect {
      Project.new(fixture("null-project")).language
    }.to raise_error(Project::UnknownLanguage)
  end

  it "should ask the language to determine the frameworks used" do
    project = Project.new(stub)
    language = stub
    language.should_receive(:frameworks).and_return([stub.as_null_object])
    project.stub(:language => language)
    project.frameworks
  end
end
