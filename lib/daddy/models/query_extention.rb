# coding: UTF-8

module Daddy
  module Models
    
    module QueryExtention
      def self.included(base)
        base.extend(ClassMethods)
      end

      module InstanceMethods
      end

      module ClassMethods
        require 'daddy/utils/sql_utils'
        include ActsAsLike::InstanceMethods

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