require "auto_data/version"
require "yaml"
module AutoData
  class Data

      def initialize()
        @data=ENV['CONF_DATA_TEST'].to_s.downcase
      end

      def load(file)
        #@file = YAML.load_file(file)

        @file = begin
                  YAML.load(File.open(file))
                rescue Exception => e  #ArgumentError
                    puts "Could not parse auto objects files: #{e.message}"
                    raise Exception.new('Could not parse auto objects files: #{e.message}')
                end
        #self
      end
      #Change environment key path
      def change_scope(data)
        @data=data.to_s.downcase
      end

      #Change data key path
      def chage_scope(data_key)
        @data=data_key.to_s.downcase
      end


      def method_missing (method)

        result= begin @file["#{@data}"]["#{method}"].nil? ? 'No Value Found' : @file["#{@data}"]["#{method}"]
        rescue NoMethodError => e
                  puts "valdio dick #{e.message}"
        end

        result
      end

      #TODO: Validar si el cambio de data scope, es correcto (existe)
      def valid_data?

      end

  end

  class Env

      def initialize()
        @env = ENV['CONF_ENV_TEST'].to_s.downcase
      end

      def load(file)
        #@file = YAML.load_file(file)
        @file = begin
                  YAML.load(File.open(file))
                rescue Exception => e  #ArgumentError
                    puts "Could not parse auto objects files: #{e.message}"
                    e.exception('adsfasdfas')
                end
        #self
      end
      #Change environment key path
      def change_scope(env)
        @env=env.to_s.downcase
      end

      def method_missing (method)
        result= begin @file["#{@env}"]["#{method}"].nil? ? 'No Value Found' : @file["#{@env}"]["#{method}"]
        rescue NoMethodError => e
                  puts "valdio dick #{e.message}"
        end
        result
      end

      #TODO: Validar si el cambio de env, es correcto (existe)
      def valid_environment?

      end
  end
end
