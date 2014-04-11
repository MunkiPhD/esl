module FoodsHelper
  def display_vitamin(display_name, value)
    unless value == 0
      raw("<tr><td>#{display_name}</td><td class=\"align_right\">#{value.to_s}%</td></tr>")
    end
  end

  def display_custom(display_name, value, unit)
    unless value == 0
      raw("<tr><td>#{display_name}</td><td class=\"align_right\">#{value.to_s}#{unit}</td></tr>")
    end
  end
end
