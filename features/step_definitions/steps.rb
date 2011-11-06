SOUNDCHECK_ROOT = File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))

Given /^the "([^"]*)" fixture$/ do |fixture_path|
  Dir.chdir(File.join(SOUNDCHECK_ROOT, "fixtures", fixture_path))
end

When /^I run "soundcheck\s?([^"]*)"$/ do |args|
  @output = `ruby -I#{File.join(SOUNDCHECK_ROOT, "lib")} #{File.join(SOUNDCHECK_ROOT, "bin", "soundcheck")} #{args} 2>&1`
end

Then /^it should have passed$/ do
  $?.exitstatus.should == 0
end

Then /^it should have failed$/ do
  $?.exitstatus.should_not == 0
end

Then /^I should see "([^"]*)"$/ do |text|
  @output.should include(text)
end