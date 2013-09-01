module RukeFu
  module ScenarioBuilder
    # Constants for step words.
    Given   = "Given"
    When    = "When"
    And     = "And"
    Then    = "Then"

    # An array of the Given, When, And, Then steps.  
    StepWords = [ Given, When, And, Then ]
    INDENT        = "    "
    # Define the regexps for capturing page names, quoted strings or options
    PAGE          = /(.*)_page$/
    QUOTED_STRING = /^['|\"](.*)['|\"]$/ # Capture single or double quoted string
    OPTIONS       = /^options\[:(.*)\]$/ # Capture the key for the options


    class << self
      def build_scenario_string(scenario_hash)
        # Pass the tags to build a string to prefix        
        tags = build_tags(scenario_hash[:tags])

        # Make the :options part of the scenario_hash into an instance var
        @options = scenario_hash[:options]
        
        @scenario_string = ""
        @scenario_string += "Scenario: "
        @scenario_string += scenario_hash[:name]
        
        # Parse through the steps in the the hash, do something based on the word
        scenario_hash[:steps].each do |word|
          if self.respond_to? word
            self.send(word) 
            next
          elsif StepWords.include? word.capitalize
            new_line # New step = new line
            indent   # We're going to need to indent on the Steps
            @scenario_string += word.capitalize + " "
            next
          elsif word.match PAGE 
            @matched = $1
            page_string
            next
          elsif word.match QUOTED_STRING
            @matched = $1
            quoted_string
          elsif word.match OPTIONS
            @matched = $1
            options(@matched)
            next
          else
            @scenario_string += "#{word} "
            next
          end

        end

        # Add a new_line to keep things tidy
        new_line
      
        tags + @scenario_string
      end
    end

    private

    def self.new_line
      # Strip the last character of the previous line so we don't have
      # trailing whitespace
      @scenario_string.strip!
      @scenario_string += "\n"
    end

    def self.indent
      @scenario_string += INDENT
    end

    def self.goto
      @scenario_string += "I go to the "
    end

    def self.page_string
      matched = @matched.split("_")
      matched.each { |word| word.capitalize! }

      matched.each do |word|
        @scenario_string += "#{word} "
      end
      @scenario_string += "Page"
    end

    def self.verify
      @scenario_string += "I verify "
    end

    def self.quoted_string
      @scenario_string += "'#{@matched}' "
    end

    def self.on
      @scenario_string += "I am on the "
    end

    # @todo This should be in a Builder class this inherits from
    def self.build_tags(tags_array)
      raise "This should be a %w[ ] array: #{tags_array}" unless tags_array.is_a? Array
      tags_string = ""
      tags_array.each do |tag|
        tags_string += tag + " "
      end

      # Always add @wip to tag the feature. Also, this means I don't need to 
      # strip the whitespace I added on the very last tag up there.
      tags_string + "@wip\n"
    end

    def self.options(key)
      raise "options[#{key}] does not exist." unless @options.include? key.to_sym
      # Convert the key to a symbol, and assign it's value
      value = @options[key.to_sym]
      # add the value to the string, converting it to a string as necessary
      @scenario_string += "#{value.to_s} "
    end

    def self.title
      @scenario_string += "the page title will be "
    end
  end
end