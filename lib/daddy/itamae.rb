require 'itamae'
require_relative 'itamae/config'
require_relative 'itamae/i18n'

Dir[File.join(File.dirname(__FILE__), 'itamae', 'ext', '**/*.rb')].each do |f|
  require f
end

Dir[File.join(File.dirname(__FILE__), 'itamae', 'env', '*.rb')].each do |f|
  require f
end
