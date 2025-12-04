module BreadcrumbsHelper
  # Accepts array of [name, path] pairs
  # Last item is considered active (current page)
  def breadcrumbs(*items)
    return if items.empty?

    content_tag(:nav, aria: { label: "breadcrumb" }) do
      content_tag(:ol, class: "breadcrumb") do
        items.map.with_index do |item, index|
          name, path = item
          active = index == items.size - 1
          content_tag(:li, class: "breadcrumb-item #{'active' if active}", aria: { current: ('page' if active) }) do
            active ? name : link_to(name, path)
          end
        end.join.html_safe
      end
    end
  end
end
