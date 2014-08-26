json.protein number_with_precision(@totals.protein, :precision => 1, :significant => false, :strip_insignificant_zeroes => true)
json.carbs number_with_precision(@totals.carbs, :precision => 1, :significant => false, :strip_insignificant_zeroes => true)
json.fat number_with_precision(@totals.total_fat, :precision => 1, :significant => false, :strip_insignificant_zeroes => true)
json.date format_date @totals.date
