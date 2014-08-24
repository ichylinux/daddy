module Daddy
  module Models
    module CrudExtension
      extend ActiveSupport::Concern

      def readable_by?(user)
        true
      end

      def creatable_by?(user)
        readable_by?(user)
      end

      def updatable_by?(user)
        readable_by?(user)
      end

      def deletable_by?(user)
        readable_by?(user)
      end

      def destroy_logically!
        self.deleted = true
        save!
      end

      module ClassMethods
      end

    end
  end
end
