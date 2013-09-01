require "minitest/autorun"
require "ruke_fu"


class TestScenario < MiniTest::Test

  def setup
    # Setup
    file = "test/scenarios_sample.rb"
    load file
  end

  def test_scenarios_can_be_loaded

    # The hash I expect to recive after the cuke.rufu file loads
    expected = [
      {
        :name => "Testing RukeFu file processing", 
        :options => {}, 
        :tags => [], 
        :steps => ["Given", "goto", "home_page", "Then", "on", "home_page"]
      },
      {
        :name => "Testing two rufu scenarios", 
        :options => {:option => 1}, 
        :tags => ["@this", "@will", "@automatically", "@become", "@an", "@array"], 
        :steps => ["Given", "goto", "home_page", "Then", "on", "home_page"]
      }
    ] 
    assert_equal expected, Scenario.get_scenarios

  end

end

class TestScenarioBuilder < MiniTest::Test

  def setup    
  end

  def test_scenario_builder
    expected = %q{@tags @in @an @array @wip
Scenario: Testing CukeRuFu file processing
    Given I go to the Home Page
    Then I am on the Home Page
    And I verify 'something' equals 'something else' as 1
    Then the page title will be 'Home Page'
}
    sample_scenarios = [
      {
        :name => "Testing CukeRuFu file processing", 
        :options => {:value => 1}, 
        :tags => ["@tags","@in","@an","@array"], 
        :steps => ["Given", "goto", "home_page", "Then", "on", "home_page", 
                   "and", "verify", "'something'", "equals", "\"something else\"",
                   "as", "options[:value]", "then", "title", "'Home Page'"]
      },
      {
        :name => "Testing two rufu scenarios", 
        :options => {:option => 1}, 
        :tags => ["@this", "@will", "@automatically", "@become", "@an", "@array"], 
        :steps => ["Given", "goto", "home_page", "Then", "on", "home_page"]
      }
    ] 

    actual = ScenarioBuilder.build_scenario_string(sample_scenarios[0])
    assert_equal expected, actual
  end
end


