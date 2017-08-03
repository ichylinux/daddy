require 'carrierwave'

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

module Daddy
  module Uploader
    class Base < CarrierWave::Uploader::Base
    end
  end
end
