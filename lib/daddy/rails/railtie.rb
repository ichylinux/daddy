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

      initializer 'carrierwave' do
        if defined?(CarrierWave)
          puts '[daddy] loading carrierwave configuration'
          require 'daddy/carrierwave'
        end
      end

      initializer 'sidekiq' do
        if defined?(Sidekiq)
          puts '[daddy] loading sidekiq configuration'
          require 'daddy/sidekiq'
        end
      end
    end
  end
end
