# coding: UTF-8

module Daddy
  module Formatter
    module DaddyHtml
      
      def before_menu
        if ENV['PUBLISH']
          @builder << "<div>"

          @builder.div(:id => 'menu') do
              @builder << make_menu_for_publish
          end

          @builder << "<div class='contents'>"
        end
      end

      def after_menu
        if ENV['PUBLISH']
          @builder << '</div>'
          @builder << '</div>'
        end
      end

      def make_menu_for_publish
        menu = Rails.root + '/tmp/menu.html'
        system("erb -T - #{File.dirname(__FILE__)}/menu.html.erb > #{menu}")
        File.readlines(menu).join
      end

      def feature_dir(feature, short = false)
        ret = ''
        
        split = feature.file.split('/')
        split.reverse[1..-2].each_with_index do |dir, i|
          break if dir == '仕様書' or dir == '開発日記'

          if i == 0
            if short
              ret = dir.split('.').first + '.'
            else
              ret = dir
            end
          else
            ret = dir.split('.').first + '.' + ret
          end
        end

        ret
      end

      def should_expand
        return false unless ENV['EXPAND']
        return false if ['f', 'false'].include?(ENV['EXPAND'].downcase)
        true
      end

    end
  end
end