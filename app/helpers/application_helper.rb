module ApplicationHelper
  def page_id
    base = controller.class.to_s.gsub('Controller', '').underscore.gsub('/', '_')
    "#{base}-#{controller.action_name}"
  end

  def default_title
    title = 'Listy: '
    title << controller_name.titleize
    title << ' - ' + action_name.titleize unless action_name == 'index'
    title
  end

  def title(page_title)
    title = 'Listy: ' + page_title
    content_for :title, title
  end

  def page_class
    controller.class.to_s.gsub('Controller', '').underscore.gsub('/', '_')
  end

  def fa_icon_with_tooltip(icon, tooltip)
    "<i class='fa fa-#{icon}' title='#{tooltip}'></i>".html_safe
  end

  def fa_icon_with_text(icon, text)
    "<i class='fa fa-#{icon}'></i> #{text}".html_safe
  end

  def setup_search_form(builder)
    # from https://github.com/activerecord-hackery/ransack_demo
    fields = builder.grouping_fields builder.object.new_grouping,
                                     object_name: 'new_object_name',
                                     child_index: 'new_grouping' do |f|
      render('grouping_fields', f: f)
    end
    script = %(var search_grouping = "#{escape_javascript(fields)}";)
    content_for :scripts, script.html_safe
  end
end
