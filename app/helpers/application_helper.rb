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
      return "#{time_ago_in_words(parsed_time)} ago"
    end
  end

  def debug(object)
    content_tag :div, class: "debug" do
      content_tag(:h5, "Debug Object: #{object.class}") +
      if object.kind_of?(ActiveRecord::Relation)
        object.collect do |child|
          content_tag(:div, child.inspect, class: 'debug-child-objects')
        end.join.html_safe
      else
        object.inspect
      end
    end
  rescue
    "an error occured"
  end
end
