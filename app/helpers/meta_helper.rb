module MetaHelper
  def meta_title(show_titulo)
	  content_for :titles do
		  content_tag(:title, show_titulo)
    end
  end

  def meta_description(show_content)
    content_for :headers do
    	"<meta name=\"description\" content=\"#{show_content}\" />\n".html_safe
    end
  end

  def meta_keywords(show_keywords)
    content_for :headers do
      "<meta name=\"keywords\" content=\"#{show_keywords}\" />\n".html_safe
    end
  end
end