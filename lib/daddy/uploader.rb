require 'carrierwave'

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

CarrierWave.configure do |config|
  config.root = 
    if ::Rails.env.test?
      "/tmp/#{::Rails.application.class.parent_name.underscore}/#{::Rails.env}"
    else
      "/data/#{::Rails.application.class.parent_name.underscore}/#{::Rails.env}"
    end
end

module Daddy
  module Uploader
    class Base < CarrierWave::Uploader::Base

      def store_dir
        "#{model.class.to_s.underscore.pluralize}/#{model.id.to_s}/#{mounted_as}"
      end

    end
  end
end
