require 'erb'

module Daddy
  module Formatter
    module DaddyHtml

      def ruby_version_dir
        unless @_ruby_version_dir
          @_ruby_version_dir = RUBY_VERSION.split('.')[0..1].join('.') + '.0'
        end
        @_ruby_version_dir
      end

      def title
        ret = ENV['TITLE']
        ret ||= Daddy.config.cucumber.title if Daddy.config.cucumber.title?
        ret ||= 'Daddy'
        ret
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
        template = File.join(File.dirname(__FILE__), 'menu.html.erb')
        ERB.new(File.read(template), 0, '-').result
      end

      def feature_id
        @feature.file.gsub(/(\/|\.|\\)/, '_')
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
        ['t', 'true'].include?(ENV['EXPAND'].to_s.downcase)
      end

      def magic_comment?(comment_line)
        comment = comment_line.to_s

        ['language', 'format'].each do |magic|
          return true if /#\s*#{magic}\s*:.*/ =~ comment
        end
        
        false
      end

    end
  end
end