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

  # object can be anything
  #   - if it's an array, it will iterate over the first level of items in the array, inspecting each
  #   - twitter bootstrap close button is implemented so that the debug windows can be dismissed and the css can be viewed in it's truer fashion
  def debug(object)
    content_tag :div, class: "debug" do
      begin
        # this uses twitter bootstrap's close button functionality
        button_tag(raw("&times;"), type: "button", class: "close", "data-dismiss" => "alert") +
          content_tag(:h5, "Debug Object: #{object.class}") +
        if object.kind_of?(ActiveRecord::Relation)
          object.collect do |child|
            content_tag(:div, child.inspect, class: 'debug-child-objects')
          end.join.html_safe
        else
          object.inspect
        end
      rescue Exception => e
        # attempt to display what went wrong as it might shed some light on another process
        content_tag(:h5, "An exception was caught in #debug: #{e.message}") + 
        content_tag(:div, e.backtrace.inspect)
      end
    end
  end
end
