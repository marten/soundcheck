# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "soundcheck"
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marten Veldthuis"]
  s.date = "2011-11-06"
  s.description = "Soundcheck tries to figure out what kind of project you're working on, what test file you're trying to run, and what the fastest way is to run that."
  s.email = "marten@veldthuis.com"
  s.executables = ["soundcheck"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "bin/soundcheck",
    "features/soundcheck.feature",
    "features/step_definitions/steps.rb",
    "fixtures/node-expresso/package.json",
    "fixtures/node-expresso/test/expresso.js",
    "fixtures/ruby-bundler-rspec/Gemfile",
    "fixtures/ruby-bundler-rspec/Gemfile.lock",
    "fixtures/ruby-bundler-rspec/spec/spec_helper.rb",
    "fixtures/ruby-bundler-rspec/spec/with_spec_helper_spec.rb",
    "fixtures/ruby-bundler-rspec/spec/without_spec_helper_spec.rb",
    "fixtures/ruby-cucumber-rspec/features/cucumber.feature",
    "fixtures/ruby-cucumber-rspec/spec/spec_helper.rb",
    "fixtures/ruby-cucumber-rspec/spec/with_spec_helper_spec.rb",
    "fixtures/ruby-cucumber-rspec/spec/without_spec_helper_spec.rb",
    "fixtures/ruby-cucumber/features/cucumber.feature",
    "fixtures/ruby-cutest/Rakefile",
    "fixtures/ruby-cutest/test/foo.rb",
    "fixtures/ruby-rspec-exception/Rakefile",
    "fixtures/ruby-rspec-exception/spec/spec_helper.rb",
    "fixtures/ruby-rspec-exception/spec/with_spec_helper_spec.rb",
    "fixtures/ruby-rspec-exception/spec/without_spec_helper_spec.rb",
    "fixtures/ruby-rspec/Rakefile",
    "fixtures/ruby-rspec/spec/spec_helper.rb",
    "fixtures/ruby-rspec/spec/with_spec_helper_spec.rb",
    "fixtures/ruby-rspec/spec/without_spec_helper_spec.rb",
    "fixtures/ruby-unknown-framework/Gemfile",
    "lib/soundcheck.rb",
    "lib/soundcheck/frameworks.rb",
    "lib/soundcheck/languages.rb",
    "lib/soundcheck/logging.rb",
    "lib/soundcheck/project.rb",
    "soundcheck.gemspec",
    "spec/soundcheck/frameworks/cucumber_spec.rb",
    "spec/soundcheck/frameworks/expresso_spec.rb",
    "spec/soundcheck/frameworks/rspec_spec.rb",
    "spec/soundcheck/frameworks/ruby_cutest_spec.rb",
    "spec/soundcheck/frameworks_spec.rb",
    "spec/soundcheck/languages_spec.rb",
    "spec/soundcheck/project_spec.rb",
    "spec/soundcheck_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/marten/soundcheck"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "Automatically runs correct test command"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, ["~> 3.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
  end
end

