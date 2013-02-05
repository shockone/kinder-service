#encoding: utf-8
module ApplicationHelper

  def render_navigation(categories = Category.roots)
    haml_tag :ul do
      categories.each do |category|
        haml_tag :li do
          haml_concat link_to_unless_current(category.name, category)
          if @current_category and category.has_descendants?
            if category == @current_category
              haml_tag(:ul) { category.children.each { |child| haml_tag :li, link_to(child.name, child) } }
            else
              render_navigation(category.children) if category.is_ancestor_of? @current_category
            end
          end
        end
      end
    end
  end

  def all_categories(categories = Category.roots, root_level=true)
    haml_tag (root_level ? 'ul.sortable' : :ul) do
      categories.each do |category|
        haml_tag "li#category-#{category.id}" do
          haml_concat
            haml_tag(:div, category.name)
            if category.has_descendants?
                all_categories(category.children, root_level=false)
            end
        end
      end
    end
  end

  def sortable_link(column, title = nil)
    title ||= column.titleize
    if column == sort_column
      title = (sort_direction == 'asc' ? '↓ ' : '↑ ') + title
    end
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, sort: column, direction: direction
  end

  def title(page_title)
    "Kinder Service#{' - ' + page_title if page_title.present?}"
  end

  def phone_number_link(text)
    sets_of_numbers = text.scan(/[0-9]+/)
    number = "+38-#{sets_of_numbers.join('-')}"
    link_to text, "tel:#{number}"
  end
end

