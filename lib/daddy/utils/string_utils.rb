require 'nkf'

module Daddy
  module Utils
    class StringUtils

      def self.to_hiragana(s)
        return s if is_empty(s)
        NKF::nkf('-Ww --hiragana', s)
      end
    
      def self.to_katakana(s)
        return s if is_empty(s)
        NKF::nkf('-Ww --katakana', s)
      end
    
      def self.to_zen(s)
        return s if is_empty(s)
        NKF::nkf('-WwXm0', s)
      end
    
      def self.to_han(s)
        return s if is_empty(s)
        NKF::nkf('-Wwxm0Z0', s)
      end
    
      def self.current_time(now = nil)
        now = Time.now unless now
        now.instance_eval { '%s%03d' % [strftime('%Y%m%d%H%M%S'), (usec / 1000.0).round] }
      end
    
      def self.rand(length = 8)
        chars = ("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a
        ret = []
        length.times do |i|
          ret[i] = chars[rand(chars.size)]
        end
        ret.join
      end

    end
  end
end
