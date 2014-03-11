module LinkHelper
  def add_link(body, url, html_options = {})
    html_options[:class] = "btn btn-success"
    link_to url, html_options do
      content_tag(:i, nil, class: "icon-plus icon-white") + " " + body
    end
  end
end
