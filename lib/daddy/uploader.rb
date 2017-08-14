CarrierWave::SanitizedFile.sanitize_regexp = /[^[:print:]]/

CarrierWave.configure do |config|
  config.root = 
    if ::Rails.env.test?
      "/tmp/#{::Rails.application.class.parent_name.underscore}/#{::Rails.env}"
    else
      "/data/#{::Rails.application.class.parent_name.underscore}/#{::Rails.env}"
    end
    
  if File.exists?('config/aws.yml')
    require 'carrierwave/storage/fog'
    config.storage :fog
    config.cache_storage :fog

    config.fog_provider = 'fog/aws'
    aws = YAML.load_file('config/aws.yml')

    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: aws['s3']['access_key_id'],
      aws_secret_access_key: aws['s3']['secret_access_key'],
      region: aws['s3']['region']
    }
    config.fog_directory = aws['s3']['bucket']
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
