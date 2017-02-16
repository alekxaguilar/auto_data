require "auto_data/version"
require "yaml"
module AutoData


  class Parse
    #TODO: Change methods to private
    def initialize()
      @gvar=ENV['AUTO_DATA_PATH'].to_s

      if @gvar.length == 0
        raise Exception.new("Variable is not defined : ENV[\'AUTO_DATA_PATH\']")
      end

      @files = Hash.new
      @file_count=0

      Dir[ @gvar + '/**/*.yml'].each { |file|  begin

        @files['fullpath_' + @file_count.to_s]=file
        @files['filename_' + @file_count.to_s]=file.split('/').last
        name =file.split('/').last.to_s.split('.').first
        @files['name_' + @file_count.to_s]=name #file.split('/').last.to_s.split('.').first
        @files["#{name}_key"]= "default_key"
        @file_count +=1
        end}
        # puts @files
    end

    def load(file)

      if @files.value?(file).nil?
        raise Exception.new("File name is not found #{file}")
      end
      key_value= @files.key(file.to_s).to_s
      key_2find = 'fullpath_' + key_value.split('_').last
      local_file_path =nil
      local_file_path= @files.values_at(key_2find)

      # @files.each_pair {|key,value| begin
      #   if key == key_2find
      #     local_file_path = value
      #     break
      #   end
      # end}

      @file = begin
              YAML.load_file(local_file_path[0].to_s)
            rescue Exception => e
                puts "Could not parse auto objects files: #{e.message}"
                raise Exception.new('Could not parse auto objects files: #{e.message}')
            end
    end

    def method_missing (filename, *args)
      fileinfo= args[0].to_s.split('.')
      if fileinfo.size !=2
        raise Exception.new('Malformed structure, must be <AutoData.filename(\'key.subkey\')> ')
      end
      key= fileinfo[0]
      subkey= fileinfo[1]
      load(filename)
      result= begin @file["#{key}"]["#{subkey}"].nil? ? 'No Value Found' : @file["#{key}"]["#{subkey}"]
      rescue NoMethodError => e
                puts "Couldn't find key #{subkey}.#{subkey} #{e.message}"
      end

      result
    end

  end
end
