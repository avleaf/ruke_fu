
module RukeFu
  class Scenario
    #include RukeFu
    attr_accessor :name, :options, :tags, :steps

    def self.current_feature
      @@current_feature ||= {}
    end

    def self.current_feature=(feature_hash)
      raise "Trying set a non-hash object onto the current feature" unless feature_hash.is_a? Hash
      @@current_feature = feature_hash
    end

    def self.reset_scenarios
      @@scenarios = []
    end

    def initialize &block
      yield self
      add_scenario(prepare_hash)
    end

    def self.get_scenarios
      @@scenarios
    end

    private

    def prepare_hash
      { :name => @name, :options => @options, 
        :tags => @tags, :steps => @steps } # The hash is returned
    end

    def scenarios
      @@scenarios ||= []
    end


    def add_scenario(scenario_hash)
      raise "Please define a Feature for this scenario" unless @@current_feature
      unless scenarios.include? scenario_hash
        scenarios # Call scenarios to ensure the value exists
        @@scenarios.push(scenario_hash) # Store this scenario in the class var 
        @@current_feature[:scenarios].push(scenario_hash)
      end
    end

  end
end