require 'i18n'
I18n.load_path += Dir.glob(File.expand_path('../../../itamae/locale/*.yml', __FILE__))
I18n.locale = ENV['LANG'][0..1] if ENV['LANG']
