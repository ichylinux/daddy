require 'simplecov-rcov'

module Daddy
  module Coverage
    class RcovFormatter < SimpleCov::Formatter::RcovFormatter
    
      private
    
      def write_file(template, output_filename, binding)
        rcov_result = template.result( binding ).force_encoding('UTF-8')
    
        File.open( output_filename, "w" ) do |file_result|
         file_result.write rcov_result
        end
      end
    end
  end
end
