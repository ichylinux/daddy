# coding: UTF-8

module Daddy
  module Utils
    
    class Config
      
      def initialize(yaml_path_or_hash = nil)
        if yaml_path_or_hash.is_a?(Hash)
          @hash = yaml_path_or_hash
        elsif yaml_path_or_hash and File.exist?(yaml_path_or_hash)
          @hash = YAML.load_file(yaml_path_or_hash)
        else
          @hash = {}
        end
      end
    
      def [](key)
        ret = false
    
        if key.to_s.end_with?('?')
          ret = @hash[key.to_s[0..-2]] ? true : false
        else
          ret = @hash[key.to_s]
    
          if ret.nil?
            ret = self.class.new
          elsif ret.is_a?(Hash)
            ret = self.class.new(ret)
          end
        end
    
        ret
      end
      
      def []=(key, value)
        @hash[key.to_s] = value
      end
      
      def method_missing(name, *args)
        self[name]
      end
    
    end

  end
end
