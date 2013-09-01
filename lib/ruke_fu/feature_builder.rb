

module RukeFu
  module FeatureBuilder
 
    INDENT   = "    "
    Feature  = "Feature:"
    # Define the regexps for capturing page names, quoted strings or options


    class << self
      def build_feature_string(feature_hash)
        # Pass the tags to build a string to prefix        
        tags = build_tags(feature_hash[:tags])

        @feature_string = ""

        title(feature_hash[:description])
        # Parse through the scenarios in the the hash, do something to them.
        feature_hash[:scenarios].each do |scenario|
          # or not.
        end

        # Add a new_line to keep things tidy
        new_line
      
        tags + @feature_string + "\n"
      end
    end

    private

    def self.new_line
      # Strip the last character of the previous line so we don't have
      # trailing whitespace
      # @feature_string
      @feature_string += "\n"
    end

    def self.indent
      @feature_string += INDENT
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


    def self.title(description)
      # split the line on the comma with a trailing space
      lines = description.split(", ")
      # Grab the Feature constant, insert it in the feature string with the first_line
      prefix = Feature
      first_line = lines.shift
      @feature_string += "#{prefix} #{first_line}"

      # Addthe remainder of the lines, with a new line, with indent
      lines.each do |line|
        new_line
        indent
        @feature_string += line
      end

      @feature_string + "\n"
    end
  end
end