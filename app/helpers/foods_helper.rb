module FoodsHelper
  def display_vitamin(display_name, value)
    unless value == 0
      raw("<tr><td>#{display_name}</td><td class=\"align_right\">#{number_with_precision(value, :precision => 0, :significant => false, :strip_insignificant_zeroes => true)}%</td></tr>")
    end
  end

  def display_custom(display_name, value, unit)
    unless value == 0
      raw("<tr><td>#{display_name}</td><td class=\"align_right\">#{number_with_precision(value, :precision => 0, :significant => false, :strip_insignificant_zeroes => true)}#{unit}</td></tr>")
    end
  end
end
