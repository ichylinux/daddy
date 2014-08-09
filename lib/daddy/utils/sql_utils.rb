module Daddy
  module Utils
    class SqlUtils

      def self.escape_search(str)
        str.gsub(/\\/, '\\\\\\\\').gsub(/%/, '\%').gsub(/_/, '\_')
      end
      
      def self.like(columns, keywords)
        target_columns = columns.is_a?(Array) ? columns : [columns]

        sql = []
        sql[0] = '('
    
        keywords.gsub(/　/, ' ').split.each_with_index do |s, i|
          like = SqlUtils.escape_search(s)

          sql[0]  << ' or ' if i > 0
          sql[0] << '('

          target_columns.each_with_index do |column, j|
            sql[0] << ' or ' if j > 0
            sql[0] << "#{column} like ?"
            sql << '%' + like + '%'
          end
    
          sql[0] << ')'
        end
    
        sql[0]  << ')'
        sql      
      end
    
    end
  end
end
