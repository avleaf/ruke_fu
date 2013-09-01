require "minitest/autorun"
#require "ruke_fu"

class TestFeature < MiniTest::Test

  def test_feature_can_be_initialized

    # Create two features, one without tags, the other with
    # Verify that they're added correctly to the @@features class variable

    # Reset features, as we're not concerned with any other features created during this run
    Feature.reset_features

    # Execute some new features
    Feature.new do |feature|
      feature.description = "In Order to organize things, A user must be able to create new Features"
    end

    Feature.new do |f|
      f.description = "In order to support multiple features, they must be created"
      f.tags        = %w[ @tag1 @tag2 ]
    end

    expected = [
      { 
        :description => "In Order to organize things, A user must be able to create new Features",
        :tags => [],
        :scenarios => [],
        :short_name => nil
      },
      {
        :description => "In order to support multiple features, they must be created",
        :tags => [ "@tag1", "@tag2" ],
        :scenarios => [], 
        :short_name => nil
      }
    ]

    assert_equal expected, Feature.get_features
  end
end

class TestFeatureBuilder < MiniTest::Test

  def test_feature_builder
    sample_hash = { 
        :description => "In Order to organize things, A user must be able to create new Features",
        :tags => [],
        :scenarios => [],
        :short_name => nil
      }

    expected = %q{@wip
Feature: In Order to organize things
    A user must be able to create new Features

}
    assert_equal expected, FeatureBuilder.build_feature_string(sample_hash)
  end
end

class TestFormatter < MiniTest::Test
  def test_format_active_feature
  
  # Run the feature and scenario creation file
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

  assert_equal expected, Formatter.get_current_feature_string

  end
end