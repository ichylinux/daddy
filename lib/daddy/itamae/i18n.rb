require 'i18n'
I18n.available_locales = [:en, :ja]
I18n.default_locale = ENV['LANG'].start_with?('ja_') ? :ja : :en
I18n.load_path += Dir.glob(File.expand_path('../../../../itamae/locale/*.yml', __FILE__))
I18n.locale = ENV['LANG'][0..1] if ENV['LANG']
