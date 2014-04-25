module LinkHelper
  def link_to_add(body, url, html_options = {})
    set_html_options(html_options, "btn btn-success")
    link_to url, html_options do
      content_tag(:span, nil, class: "glyphicon glyphicon-plus icon-white") + " " + body
    end
  end


  def link_to_destroy(body, url, html_options = {})
    set_html_options(html_options, "btn btn-danger")
    button_to url, html_options do
      content_tag(:span, nil, class: "glyphicon glyphicon-remove icon-white") + " " + body
    end
  end


  def link_to_edit(body, url, html_options = {})
    set_html_options(html_options, "btn btn-primary")
    link_to url, html_options do
      content_tag(:span, nil, class: "glyphicon glyphicon-pencil icon-white") + " " + body
    end
  end


  def button_to_submit(value="Save Changes", options={})
    set_html_options(options, "btn btn-info")
    options[:name] = "commit"

    button_tag(type: "submit", name: "commit", class: "btn btn-info", options: options) do
      content_tag(:snap, nil, class: "glyphicon glyphicon-ok icon-white") + " " + value
    end
  end


  private
  def set_html_options(html_options = {}, additional_options)
    html_options[:class] ||= ""
    html_options[:class] << " " + additional_options
    html_options
  end
end
