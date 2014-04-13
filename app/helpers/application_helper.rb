module ApplicationHelper
  def format_date(date)
    unless date.nil?
      date.strftime('%d-%B-%Y')
    end
  end


  def days_ago(date)
    if date == Date.today
      return "Today"
    else
      parsed_time = Time.parse(date.strftime('%d-%b-%y')) + (-Time.zone_offset(Time.now.zone))
      if parsed_time > Date.today
        return "#{time_ago_in_words(parsed_time)} in the future"
      else
        return "#{time_ago_in_words(parsed_time)} ago"
      end
    end
  end
end
