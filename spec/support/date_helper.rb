module DateHelper
  def format_date(date)
    unless date.nil?
      date.strftime('%d-%B-%Y')
    end
  end
end
