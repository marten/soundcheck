Feature: Soundcheck
  In order to run my tests quickly
  I want to require as little as possible

  Scenario: Ruby and RSpec
    Given the "ruby/rspec" fixture
    When I run soundcheck with "spec"
    Then it should have passed