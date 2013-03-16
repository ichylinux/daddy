# coding: UTF-8

module Daddy
  module Cucumber
    module Html
      
      def find_tr(table_selector, text, fail_on_missing = true)
        within table_selector do
          all('tr').each do |tr|
            if tr.text.include?(text)
              if block_given?
                within tr do
                  yield tr
                end
              end
              return tr
            end
          end
        end
        
        fail "テーブル #{table_selector} 内に #{text} を含む行が見つかりませでした。" if fail_on_missing
      end
    
      def find_option(select_selector, text, fail_on_missing = true)
        within select_selector do
          all('option').each do |option|
            if option.text.include?(text)
              if block_given?
                within option do
                  yield
                end
              end
              return option
            end
          end
        end
        
        fail "セレクトボックス #{select_selector} 内に #{text} を含むオプションが見つかりませでした。" if fail_on_missing
      end

      def confirm(ok = true)
        puts("確認ダイアログで #{ok ? 'OK' : 'キャンセル'} をクリック")
        return unless Capybara.current_driver == :selenium

        if ok
          page.driver.browser.switch_to.alert.accept
        else
          page.driver.browser.switch_to.alert.deny
        end
      end

    end
  end
end

World(Daddy::Cucumber::Html)
