Given /^the "([^"]*)" fixture$/ do |fixture_path|
  Dir.chdir(File.join(File.expand_path(File.dirname(__FILE__)), "../../spec/fixtures", fixture_path))
end

When /^I run soundcheck with "([^"]*)"$/ do |spec_file|
  puts output = `#{File.join(File.expand_path(File.dirname(__FILE__)), "../../bin/soundcheck")} #{spec_file}`
end

Then /^it should have passed$/ do
  $?.exitstatus.should == 0
end