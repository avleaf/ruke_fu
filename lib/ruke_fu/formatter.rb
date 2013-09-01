module RukeFu
  class Formatter
    def self.get_current_feature_string
      output = ""
      current_feature = Feature.get_current_feature
      output += FeatureBuilder.build_feature_string current_feature
      scenarios = current_feature[:scenarios]
      scenarios.each do |scenario|
        output += ScenarioBuilder.build_scenario_string(scenario)
        output += "\n"
      end
      output
    end

  end
end

