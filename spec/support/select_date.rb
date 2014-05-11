#
# http://stackoverflow.com/questions/6729786/how-to-select-date-from-a-select-box-using-capybara-in-rails-3
#
module SelectDateHelper
  # use as so: '2014,January, 1'
  def select_date(date, options = {})
    field = options[:from]
    base_id = find(:xpath, ".//label[contains(.,'#{field}')]")[:for]
    year, month, day = date.split(',')
    select year,  :from => "#{base_id}_1i"
    select month, :from => "#{base_id}_2i"
    select day,   :from => "#{base_id}_3i"
  end

  def select_log_date(date, id)
	  select date.strftime('%-d'), from: "#{id}_3i"
	  select date.strftime('%B'), from: "#{id}_2i"
	  select date.strftime('%Y'), from: "#{id}_1i"
  end
end
