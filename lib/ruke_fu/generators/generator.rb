module RukeFu

  # include ::ERB
  class Generator 

  #include ERB::Util
    # include ERB
    #include FileUtils

    def initialize(args)
      
    end
    
    def write_file(short_name, template)
      feature_file = "#{short_name}.feature"
      File.open(feature_file, "w+") do |f|
        f.write(render(template))
      end

    end

    def render(template)

      erb = ERB.new(template).result binding
      erb
    end



    # def create_directories
    #   mkdir "features/"
    #   mkdir "features/support/"
    #   mkdir "features/support/pages/"
    #   mkdir "features/step_definitions/"
    # end
  end
end