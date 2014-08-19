module Daddy
  class Model < Hash
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    def initialize(params = {})
      self.merge!(params.stringify_keys) if params
    end

    def persisted?
      false
    end

    def method_missing(method, *params)
      method_name = method.to_s
      if method_name.last == '='
        self[method_name[0..-2]] = params.first
      else
        self[method_name]
      end
    end
  end
end
