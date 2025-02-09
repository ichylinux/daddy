CarrierWave::SanitizedFile.sanitize_regexp = /[^[:print:]]/

CarrierWave.configure do |config|
  config.root = 
    if ::Rails.env.test?
      "/tmp/#{::Rails.application.class.module_parent_name.underscore}/#{::Rails.env}"
    else
      "/data/#{::Rails.application.class.module_parent_name.underscore}/#{::Rails.env}"
    end

  if File.exists?('config/aws.yml')
    aws = YAML.safe_load(ERB.new(File.read('config/aws.yml'), 0, '-').result)

    if aws.dig('s3', 'enabled')
      require 'carrierwave/storage/fog'
      config.storage :fog
      config.cache_storage :fog
      config.fog_provider = 'fog/aws'

      config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: aws['s3']['access_key_id'],
        aws_secret_access_key: aws['s3']['secret_access_key'],
        region: aws['s3']['region']
      }
      config.fog_directory = aws['s3']['bucket']
      config.fog_public = aws['s3'].fetch('public', false)
    end
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
