require "auto_data/version"
require "yaml"
module AutoData


  class Parse
    def initialize()
      @gvar=ENV['AUTO_DATA_PATH'].to_s
      if @gvar.length == 0
        raise Exception.new("Variable is not defined : ENV[\'AUTO_DATA_PATH\']")
      end
      @files = Hash.new
      @file_count=0
      Dir[@gvar + '/**/*.yml'].each { |file|
        begin
          @files['fullpath_' + @file_count.to_s]=file
          @files['filename_' + @file_count.to_s]=file.split('/').last
          @name_def_key =file.split('/').last.to_s.split('.').first
          @files['name_' + @file_count.to_s]=@name_def_key #file.split('/').last.to_s.split('.').first
          @info = begin
            YAML.load_file(file)
          rescue Exception => e
            puts "Could not parse auto objects files: #{e.message}"
            raise Exception.new('Could not parse auto objects files: #{e.message}')
          end
          @files["#{@name_def_key}_default_key"]= begin
            @info["default_key"].nil? ? 'NotFound' : @info["default_key"]
          rescue NoMethodError => e
            puts "Couldn't find key #{default_key} - #{e.message}"
          end

          @file_count +=1
        end }
      # puts @files
    end

    def change_scope(filename, new_value)
      if !@files.value?(filename)
        raise Exception.new("File name '#{filename}' is not found")
      else
        @files["#{filename}_default_key"] = new_value
      end
    end #End change_scope

    private
    def method_missing (filename, *args)
      use_default_key= false
      if args[0].count('.') == 0 #use custom key; >0 usedefault_key
        use_default_key=true
        subkey=args[0].to_s
      else
        fileinfo= args[0].to_s.split('.')
        if fileinfo.size !=2
          raise Exception.new('Malformed structure, must be <AutoData.filename(\'key.subkey\')> ')
        end
        key= fileinfo[0]
        subkey= fileinfo[1]
      end

      private
      load(filename)#call
      if use_default_key
        if @files.key?(filename.to_s + '_default_key')
          default_key = @files["#{filename}_default_key"]
        else
          raise Exception.new("Couldn't find key default_key. ")
        end
        result= begin
          @file["#{default_key}"]["#{subkey}"].nil? ? 'No Value Found' : @file["#{default_key}"]["#{subkey}"]
        rescue NoMethodError => e
          puts "Couldn't find key #{subkey} using 'default_key' #{e.message}"
          raise Exeption.new("Couldn't find key #{subkey} using 'default_key' #{e.message}")
        end
      else
        result= begin
          @file["#{key}"]["#{subkey}"].nil? ? 'No Value Found' : @file["#{key}"]["#{subkey}"]
        rescue NoMethodError => e
          puts "Couldn't find key #{key}.#{subkey} #{e.message}"
          raise Exception.new("Couldn't find key #{key}.#{subkey} #{e.message}" )
        end
      end

      result
    end #End method_missing

    private
    def load(file)

      if @files.value?(file).nil?
        raise Exception.new("File name is not found #{file}")
      end
      key_value= @files.key(file.to_s).to_s
      key_2find = 'fullpath_' + key_value.split('_').last
      local_file_path= @files.values_at(key_2find)
      @file = begin
        YAML.load_file(local_file_path[0].to_s)
      rescue Exception => e
        puts "Could not parse auto objects files: #{e.message}"
        raise Exception.new('Could not parse auto objects files: #{e.message}')
      end
    end #end Load


  end #End Parse Class


end #End Module
