# coding: UTF-8

module Daddy
  module Cucumber
    module Table
      def normalize_table(ast_table)
        ret = []
      
        ast_table.raw.each do |ast_row|
          row = []
      
          ast_row.each do |ast_col|
            value = ast_col.gsub(/　/, '')
            row << value
          end
      
          ret << row
        end
      
        ret
      end
    end
  end
end