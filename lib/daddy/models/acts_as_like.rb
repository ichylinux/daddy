# coding: UTF-8

require 'daddy/utils/sql_utils'

module Daddy
  module Models
    
    module ActsAsLike
      module Mixin
        def acts_as_like(options = {})
          extend ClassMethods
          include InstanceMethods
        end
      end
      
      module ClassMethods

        def like(columns, keywords)
          where(Daddy::Utils::SqlUtils.like(columns, keywords))
        end

      end
      
      module InstanceMethods
      end
    end

  end
end