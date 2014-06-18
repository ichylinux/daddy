module Daddy
  module Models
    
    module QueryExtension
      def self.included(base)
        base.extend(ClassMethods)
        base.__send__(:include, InstanceMethods)
      end

      module InstanceMethods
      end

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