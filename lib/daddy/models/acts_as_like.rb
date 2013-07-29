# coding: UTF-8

module Daddy
  module Models
    
    module ActsAsLike
      def self.included(base)
        base.extend(ClassMethods)
      end

      module InstanceMethods
      end

      module ClassMethods
        require 'daddy/utils/sql_utils'
        include ActsAsLike::InstanceMethods

        def like(columns, keywords)
          where(Daddy::Utils::SqlUtils.like(columns, keywords))
        end
      end

    end

  end
end