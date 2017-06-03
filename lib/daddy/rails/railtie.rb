require 'rails_i18n'
require 'holiday_jp'
require 'daddy/helpers/html_helper'
require 'daddy/http_client'
require 'daddy/model'
require 'daddy/ocr'

module Daddy
  module Rails
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        if config.action_view.javascript_expansions
          config.action_view.javascript_expansions[:defaults] |= ['daddy']
        end
      end
  
      initializer 'active_record_extension' do
        ActiveSupport.on_load :active_record do
          require 'daddy/models/crud_extension'
          require 'daddy/models/query_extension'
          ActiveRecord::Base.send(:include, Daddy::Models::CrudExtension)
          ActiveRecord::Base.send(:include, Daddy::Models::QueryExtension)
        end
      end

      initializer 'sidekiq' do
        if defined?(Sidekiq)
          require 'daddy/sidekiq'
        end
      end
    end
  end
end
