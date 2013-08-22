# coding: UTF-8

module Daddy
  module Models
    
    module CrudExtension
      def self.included(base)
        base.extend(ClassMethods)
        base.__send__(:include, InstanceMethods)
      end

      module InstanceMethods
        def destroy_logically!
          self.deleted = true
          save!
        end
      end

      module ClassMethods
      end

    end

  end
end
