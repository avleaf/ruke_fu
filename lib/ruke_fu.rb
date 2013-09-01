require 'awesome_print'
require 'ruke_fu/scenario'
require 'ruke_fu/scenario_builder'
require 'ruke_fu/feature'
require 'ruke_fu/feature_builder'
require 'ruke_fu/formatter'

# These paths are gross
require 'ruke_fu/generators/generator'
require "ruke_fu/generators/feature/feature"

module RukeFu
  VERSION = "0.0.1"


  # Alias Scenario so you don't have to type RukeFu in the scenario file.
  ::Scenario        = RukeFu::Scenario
  ::ScenarioBuilder = RukeFu::ScenarioBuilder
  ::Feature         = RukeFu::Feature
  ::FeatureBuilder  = RukeFu::FeatureBuilder
  ::Formatter       = RukeFu::Formatter  

  
end
 
