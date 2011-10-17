SOUNDCHECK_ROOT = File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))

Given /^the "([^"]*)" fixture$/ do |fixture_path|
  Dir.chdir(File.join(SOUNDCHECK_ROOT, "spec", "fixtures", fixture_path))
end

When /^I run soundcheck with "([^"]*)"$/ do |spec_file|
  puts output = `ruby -I#{File.join(SOUNDCHECK_ROOT, "lib")} #{File.join(SOUNDCHECK_ROOT, "bin", "soundcheck")} #{spec_file}`
end

Then /^it should have passed$/ do
  $?.exitstatus.should == 0
end