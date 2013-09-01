require "minitest/autorun"
require 'erb' unless defined?(ERB)

class TestFeatureGenerator < MiniTest::Test

  def test_feature_template

    file = "test/features_sample.rb"
    load file

    expected = %q{@feature @level @tags @wip
Feature: In order to test RukeFu
    the application must sort scenarios
    into features

@wip
Scenario: Testing RukeFu file processing
    Given I go to the Home Page
    Then I am on the Home Page

@this @will @automatically @become @an @array @wip
Scenario: Testing two rufu scenarios
    Given I go to the Home Page
    Then I am on the Home Page

}

    result = RukeFu::Generators::Feature.new
    assert_equal expected, result.render
  end

  def test_write_feature_file
    file = "test/features_sample.rb"
    load file

    
    new_generated_feature = RukeFu::Generators::Feature.new
    new_generated_feature.write_feature

    # Expected file name and path.
    sample_file = "testing_sample.feature"
    
    # Verify the file was created
    assert File.exists? sample_file
    
    expected = %q{@feature @level @tags @wip
Feature: In order to test RukeFu
    the application must sort scenarios
    into features

@wip
Scenario: Testing RukeFu file processing
    Given I go to the Home Page
    Then I am on the Home Page

@this @will @automatically @become @an @array @wip
Scenario: Testing two rufu scenarios
    Given I go to the Home Page
    Then I am on the Home Page

}
    
    # Verify the content of the file is what we expect
    assert_equal expected, File.readlines(sample_file).join

    # Delete the file as necessary
    File.delete sample_file if File.exists? sample_file
  end
end
