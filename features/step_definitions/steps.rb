SOUNDCHECK_ROOT = File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))

Given /^the "([^"]*)" fixture$/ do |fixture_path|
  Dir.chdir(File.join(SOUNDCHECK_ROOT, "fixtures", fixture_path))
end

When /^I run "soundcheck ([^"]*)"$/ do |args|
  @output = `ruby -I#{File.join(SOUNDCHECK_ROOT, "lib")} #{File.join(SOUNDCHECK_ROOT, "bin", "soundcheck")} #{args}`
end

Then /^it should have passed$/ do
  $?.exitstatus.should == 0
end

Then /^I should see "([^"]*)"$/ do |text|
  @output.should include(text)
end