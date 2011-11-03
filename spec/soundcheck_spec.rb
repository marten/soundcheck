require File.expand_path(File.dirname(__FILE__) + '/../lib/soundcheck')

CURRENT_PWD   = Dir.pwd
FIXTURES_ROOT = File.expand_path(File.dirname(__FILE__) + '/../fixtures')

def cmd_for(path = nil, options = {})
  Soundcheck.new(path, options).command_to_run
end

describe "Soundcheck" do
  context "for a ruby project" do
    context "using rspec" do
      before(:all) { Dir.chdir(FIXTURES_ROOT + '/ruby-rspec') }

      it "should not use bundler when no Gemfile exists" do
        cmd_for.should == "rspec spec"
      end

      context "using bundler" do
        before(:all) { Dir.chdir(FIXTURES_ROOT + '/ruby-bundler-rspec') }

        it "should return 'bundle exec rspec spec' when run with no arguments" do
          cmd_for.should == "bundle exec rspec spec"
        end

        it "should run only fast specs" do
          cmd_for("spec", fast: true).should == "rspec spec/without_spec_helper_spec.rb"
        end

        it "should return 'bundle exec rspec spec/with_spec_helper_spec.rb'" do
          cmd_for('spec/with_spec_helper_spec.rb').should == "bundle exec rspec spec/with_spec_helper_spec.rb"
        end

        it "should return 'rspec spec/without_spec_helper_spec.rb'" do
          cmd_for('spec/without_spec_helper_spec.rb').should == "rspec spec/without_spec_helper_spec.rb"
        end
      end
    end
    
    context "using minitest"
    context "using test::unit"
  end

  context "for a python project"
end
