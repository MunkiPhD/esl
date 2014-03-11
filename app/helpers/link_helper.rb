module LinkHelper
  def link_to_add(body, url, html_options = {})
    set_html_options(html_options, "btn btn-success")
    link_to url, html_options do
      content_tag(:i, nil, class: "icon-plus icon-white") + " " + body
    end
  end


  def link_to_destroy(body, url, html_options = {})
    set_html_options(html_options, "btn btn-danger")
    html_options[:method] = :delete
    html_options[:data] = { confirm: "Are you sure?" }
    link_to url, html_options do
      content_tag(:i, nil, class: "icon-remove icon-white") + " " + body
    end
  end


  def link_to_edit(body, url, html_options = {})
    set_html_options(html_options, "btn btn-primary")
    link_to url, html_options do
      content_tag(:i, nil, class: "icon-pencil icon-white") + " " + body
    end
  end


  private
  def set_html_options(html_options = {}, additional_options)
    html_options[:class] ||= ""
    html_options[:class] << " " + additional_options
    html_options
  end
end
