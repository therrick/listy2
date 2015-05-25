module StoresHelper
  def sort_link
    if session[:sort] == 'pop'
      link = link_to 'sort by name', sort: 'name', search: params[:search]
    else
      link = link_to 'sort by pop.', sort: 'pop', search: params[:search]
    end
    ("<span class=\"sort_link\">(" + link + ')</span>').html_safe
  end
end
