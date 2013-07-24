# coding: UTF-8

class SqlBuilder

  def initialize
    @sql = []
    @params = []
  end

  def append(*args)
    if args.size == 1
      if args[0].is_a?(Array)
        append_array(args[0])
      elsif args[0].is_a?(SqlBuilder)
        append(args[0].to_a)
      else
        append_string(args[0])
      end
    else
      append_array(args)
    end

    self
  end
  
  def and(*args)
    append_string('and (')
    
    if block_given?
      yield self
    else
      append(*args)
    end
    
    append_string(')')
  end

  def or(*args)
    append_string('or (')

    if block_given?
      yield self
    else
      append(*args)
    end

    append_string(')')
  end
  
  def to_a
    [@sql.join(' ')] + @params
  end
  
  private
  
  def append_string(sql)
    @sql << sql
  end
  
  def append_array(array)
    array.each_with_index do |x, i|
      if i == 0
        append_string(x)
      else
        @params << x
      end
    end
  end
end
