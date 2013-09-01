module RukeFu
  class Feature
    attr_writer :description, :tags, :scenarios

    # The short_name should be used to assist in naming the feature file
    attr_accessor :short_name

    # ToDo: Add support for feature_hash[:background_steps] 

    def initialize &block
      # Allow the block to define the feature
      yield self
      # Create a hash of the instance variables set by the block
      feature_hash      = prepare_hash
      # Use the class variable to maintain the most recentily defined feature
      @@current_feature = feature_hash
      # store the feature in the @@features class variable
      add_feature(feature_hash)
    end

    def self.get_features
      @@features
    end

    def self.get_current_feature
      @@current_feature
    end

    def self.reset_features
      @@features = []
    end

    private

    def add_feature(feature_hash)
      # Prevent the feature from being duplicated.
      raise "Feature #{feature_hash} defined more than once" if features.include? feature_hash

      # Store this feature in the class var
      @@features.push(feature_hash)  
      
      # Give scenarios some context so they know where to go.
      RukeFu::Scenario.current_feature= feature_hash
      RukeFu::Scenario.reset_scenarios # Reset the scenarios class var in 
      feature_hash
    end

    def prepare_hash
      { :description => description, :short_name => short_name,
        :tags => tags, :scenarios => scenarios } # The hash is returned
    end

    def description
      @description ||= "No feature text defined"
    end

    def features
      @@features ||= []
    end

    def scenarios
      @scenarios ||= []
    end

    def tags
      @tags ||= []
    end
  end
  
end