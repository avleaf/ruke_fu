
module RukeFu
  module Generators
    class Feature < Generator

      attr_accessor :current_feature
      # May want to implement Thor for command line use? Maybe not.

      def initialize 
        feature_string   = Formatter.get_current_feature_string
        @feature_hash    = ::Feature.get_current_feature
        @current_feature = feature_string
        @short_name      = short_name(@feature_hash) 
        @template        = self.get_template
        self
      end

      def get_template
        # Currently, this is redundant, as the template is identical to 
        # the feature string
        "<%= @current_feature %>"
      end
      
      def write_feature
        self.write_file(@short_name, @template)
      end

      def render(template = @template)
        super(template)
      end

      private

      def short_name(feature_hash)
        # Nil guarud for @@unnamed_feature_count
        @@unnamed_feature_count ||= 0
        # create a feature name, incase one wasn't declared. 
        unless feature_hash[:short_name]
          @@unnamed_feature_count  += 1
          feature_hash[:short_name] = "unnamed_feature_#{@@unnamed_feature_count}" 
        end
        feature_hash[:short_name]
      end



    end
  end
end