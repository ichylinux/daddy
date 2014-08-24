module Daddy
  module Models
    
    module QueryExtension
      extend ActiveSupport::Concern

      module ClassMethods
        require 'daddy/utils/sql_utils'

        def not_deleted
          where(:deleted => false)
        end

        def like(columns, keywords)
          where(Daddy::Utils::SqlUtils.like(columns, keywords))
        end
      end

    end

  end
end