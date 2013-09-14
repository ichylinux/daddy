module Differ
  module Format
    module HTML
      class << self

      private
        def as_change(change)
          as_delete(change) << "\n" << as_insert(change)
        end
      end
    end
  end
end
