# coding: UTF-8

module Daddy
  module Cucumber
    module Assert
      def assert_url(path, params = {})
        # スクリーンショットの保存
        capture
      
        # パスのチェック
        re = path.gsub(/\//, '\/')
        assert /#{re}/ =~ current_path, "想定しているパスではありません。想定 #{path} : 実際 #{current_path}"
        
        # パラメータのチェック
        current_params = get_current_params()
        params.each do |key, value|
          re = value
          assert /#{re}/ =~ current_params[key], "#{key}が想定している値ではありません。想定 #{value} : 実際 #{current_params[key]}"
        end
      end
      
      def assert_visit(path, params = {})
        query_string = ''
        params.each do |key, value|
          if query_string.empty?
            query_string += '?'
          else
            query_string += '&'
          end
          query_string += (key.to_s + '=' + value.to_s)
        end
      
        visit path + query_string
        assert_url path, params
      end
      
      def assert_fill_in(field_name, value)
        fill_in field_name, :with => value
        capture
      end
      
      def assert_check(field_name)
        check field_name
        capture
      end
      
      def assert_uncheck(field_name)
        uncheck field_name
        capture
      end
      
      def assert_choose(field_name)
        choose field_name
        capture
      end
      
      def assert_select(name, value)
        select value, :from => name
        capture
      end
      
      def assert_selector(selector, options = {})
        assert page.has_selector?(selector), options[:message]
        capture if options[:capture]
      end
      
      def assert_no_selector(selector, options = {})
        assert page.has_no_selector?(selector), options[:message]
        capture if options[:capture]
      end
      
      def assert_present(value, message = nil)
        assert value.present?, message
      end
      
      def assert_not_present(value, message = nil)
        assert ! value.present?, message
      end
      
      def assert_content_type(content_type)
        assert_equal content_type, page.response_headers['Content-Type']
      end
      
      def assert_iterate(array)
        iterated = false
        
        array.each do |x|
          iterated ||= yield x
        end
        
        fail 'テスト対象のデータがありません。' unless iterated
      end
      
      def get_current_params
        ret = {}
        if current_url.include?('?')
          current_url.split('?')[1].split('&').each do |query_string|
            key, value = query_string.split('=')
            ret.store key.to_sym, value
          end
        end
        ret
      end

    end
  end
end

World(Daddy::Cucumber::Assert)
