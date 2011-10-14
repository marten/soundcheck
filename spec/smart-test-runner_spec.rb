CURRENT_PWD   = Dir.pwd
FIXTURES_ROOT = File.expand_path(File.dirname(__FILE__) + '/fixtures')

describe "SmartTestRunner" do
  context "for a ruby project" do
    context "using rspec" do
      before(:all) { Dir.chdir(FIXTURES_ROOT + '/ruby/rspec') }
      after(:all)  { Dir.chdir(CURRENT_PWD) }

      it "should return 'bundle exec rspec spec' when run with no arguments" do
        SmartTestRunner.command_to_run().should == "bundle exec rspec spec"
      end

      it "should return 'bundle exec rspec spec/with_spec_helper_spec.rb'" do
        SmartTestRunner.command_to_run('spec/with_spec_helper_spec.rb').should == "bundle exec rspec spec/with_spec_helper_spec.rb"
      end

      it "should return 'rspec spec/without_spec_helper_spec.rb'" do
        SmartTestRunner.command_to_run('spec/without_spec_helper_spec.rb').should == "rspec spec/without_spec_helper_spec.rb"
      end

      it "should not use bundler when no Gemfile exists"
      it "should not call rspec outside of bundler when the rspec command does not exist"
    end
    
    context "using minitest"
  end

  context "for a python project"
end
