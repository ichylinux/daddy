# coding: UTF-8

module Tax

  # 消費税区分
  TAX_TYPES = {
    TAX_TYPE_NONTAXABLE = 1 => '非課税',
    TAX_TYPE_INCLUSIVE = 2 => '内税',
    TAX_TYPE_EXCLUSIVE = 3 => '外税',
  }

  RATE_3 = Date.parse('1989-04-01');
  RATE_5 = Date.parse('1997-04-01');
  RATE_8 = Date.parse('2014-04-01');

  def self.get_rate_on(date, options = {})
    if (date.is_a?(String))
      date = Date.parse(date)
    end

    if (date >= RATE_3 && date < RATE_5)
      ret = 0.03;
    elsif (date >= RATE_5 && date < RATE_8)
      ret = 0.05;
    elsif (date >= RATE_8)
      ret = 0.08;
    else
      ret = 0
    end

    if options[:percent]
      ret *= 100
    end
    
    ret
  end

end