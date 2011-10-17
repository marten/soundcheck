require File.expand_path(File.dirname(__FILE__) + '/../lib/soundcheck')

CURRENT_PWD   = Dir.pwd
FIXTURES_ROOT = File.expand_path(File.dirname(__FILE__) + '/fixtures')

describe "Soundcheck" do
  context "for a ruby project" do
    context "using rspec" do
      before(:all) { Dir.chdir(FIXTURES_ROOT + '/ruby/rspec') }
      after(:all)  { Dir.chdir(CURRENT_PWD) }

      it "should return 'bundle exec rspec spec' when run with no arguments" do
        Soundcheck.new().command_to_run.should == "bundle exec rspec spec"
      end

      it "should return 'bundle exec rspec spec/with_spec_helper_spec.rb'" do
        Soundcheck.new('spec/with_spec_helper_spec.rb').command_to_run.should == "bundle exec rspec spec/with_spec_helper_spec.rb"
      end

      it "should return 'rspec spec/without_spec_helper_spec.rb'" do
        Soundcheck.new('spec/without_spec_helper_spec.rb').command_to_run.should == "rspec spec/without_spec_helper_spec.rb"
      end

      it "should not use bundler when no Gemfile exists"
      it "should not call rspec outside of bundler when the rspec command does not exist"
    end
    
    context "using minitest"
  end

  context "for a python project"
end
