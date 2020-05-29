class String
  def color_code(code)
    "\e[#{code}m#{self}\e0"
  end

  def default
    color_code(39)
  end

  def unrated
    # magenta
    color_code(35)
  end

  def bronze
    # default
    color_code(39)
  end

  def silver
    # light grey
    color_code(37)
  end

  def gold
    # yellow
    color_code(93)
  end

  def platinum
    # light cyan
    color_code(96)
  end

  def diamond
    # blue
    color_code(34)
  end

  def ruby
    # red
    color_code(31)
  end
end

def color(str)
  temp = str.to_s.scan(/[a-z]/).join
  str = str.to_s
  case temp
  when 'unrated' then str.unrated
  when 'bronze' then str.bronze
  when 'silver' then str.silver
  when 'gold' then str.gold
  when 'platinum' then str.platinum
  when 'diamond' then str.diamond
  when 'ruby' then str.ruby
  end
end

