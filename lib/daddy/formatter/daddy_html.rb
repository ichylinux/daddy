# coding: UTF-8

module Daddy
  module Formatter
    module DaddyHtml
      
      def title
        ENV['TITLE'] || 'Daddy'
      end
      
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
        FileUtils.mkdir_p('tmp')
        menu = File.join('tmp', 'menu.html')
        system("erb -T - #{File.dirname(__FILE__)}/menu.html.erb > #{menu}")
        File.read(menu)
      end

      def scenario_id
        @feature.file.gsub(/(\/|\.|\\)/, '_') + '_scenario_' + @scenario_number.to_s
      end

      def feature_dir(feature, short = false)
        ret = ''
        
        split = feature.file.split(File::SEPARATOR)
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