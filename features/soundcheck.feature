Feature: Soundcheck
  In order to run my tests quickly
  I want to require as little as possible

  Scenario: Command line help
    When I run "soundcheck --help"
    Then I should see "Usage: soundcheck"

  Scenario: Ruby and RSpec
    Given the "ruby-bundler-rspec" fixture
    When I run "soundcheck spec"
    Then it should have passed

  Scenario: Ruby and RSpec backtraces
    Given the "ruby-rspec-exception" fixture
    When I run "soundcheck --trace spec"
    Then I should see "1 failure"
    And I should see "gems/rspec-core"