#coding : utf-8
module ApplicationHelper

  def error_message_for(resource)
    render "/admin/shared/error_message",:target => resource
  end

  def show_situation_status(objeto)
    if objeto.is_a?(TrueClass)
      "Ativo no sistema"
    elsif objeto.is_a?(FalseClass) || content.is_a?(NilClass)
      "Desativado no sistema"
    end
  end

  def page_sub_title(sub_title)
    content_for :sub_titulo_pagina do
      content_tag(:h1, sub_title,:class => 'well')
    end
  end

  def list_last_five_categories
    html = %()
    categories = Category.last_five

    unless categories.empty?
      html << content_tag(:li, "<i class='icon-tags'></i>Ultimas categorias".html_safe, :class => 'nav-header')
      categories.each { |category| html << content_tag(:li, link_to(category.name, admin_category_path(category), :title => 'Veja os detalhes')) } 
  	  html << "<hr />" << link_to('veja todas', admin_categories_path)   
    else
      html << content_tag(:li, "<i class='icon-tags'></i>Não há categorias".html_safe, :class => 'nav-header')
		end

    content_tag(:div, content_tag(:ul, html.html_safe, :class => 'nav nav-list'), :class => 'well span5')
  end

  def list_last_five_posts
    html = %()
    posts = Post.last_five
    unless posts.empty?
      html << content_tag(:li, "<i class='icon-tags'></i>Ultimas categorias".html_safe, :class => 'nav-header')
      posts.each { |post| html << content_tag(:li, link_to(post.name, admin_post_path(post), :title => 'Veja os detalhes')) } 
  	  html << "<hr />" << link_to('veja todas', admin_posts_path)   
    else
      html << content_tag(:li, "<i class='icon-tags'></i>Não há posts".html_safe, :class => 'nav-header')
		end

    content_tag(:div, content_tag(:ul, html.html_safe, :class => 'nav nav-list'), :class => 'well span5')
  end

  def list_new_comments
    has_new_comments = Comment.has_new_comments
    html = %()
    unless has_new_comments.empty?
      has_new_comments.each do |comment|
        url = "/admin/posts/#{comment.post.id}#comment_for_post"
        html << content_tag(:div, :class => 'alert alert-info') do 
          content_tag(:button,'x',:class => 'close', data: { dismiss: "alert"}) +
          "<i class='icon-eye-open'></i> Post : <strong>#{comment.post.name}</strong>, possui  novos comentarios, #{link_to("<strong>Veja aqui</strong>".html_safe, url)}".html_safe   
        end
      end
    end
    html.html_safe
  end

  def create_menus
    html = %()
    Util.list_models.each { |model| html << render('admin/shared/menu_item', :model_for_menu => model) }
    html.html_safe
  end

  def list_all_categories(categories)
    html = %()
    html << content_tag(:li, "<i class='icon-list-alt'></i>Todas Categorias".html_safe, :class => 'nav-header')
    unless categories.empty?
      categories.each do |category|
        html << content_tag(:li, link_to("#{category.name}&nbsp;&nbsp;&nbsp;<span class='label label-info alinhamento'>#{category.posts.size}</span>".html_safe, "/filtro_por_categoria/#{category.to_param}", :title => 'filtre os posts pela categoria' ))
      end    
    end   
    content_tag(:div, content_tag(:ul, html.html_safe, :class => 'nav nav-list'), :class => 'well')
  end

  def mais_comentados(objetos)
    html = %()
    unless objetos.empty?
      html << content_tag(:li, "<i class='icon-list-alt'></i>Mais comentados".html_safe, :class => 'nav-header')
      objetos.each do |comment|
        html << content_tag(:li, link_to("#{comment.post.name}&nbsp;&nbsp;&nbsp;<span class='label label-info alinhamento'>#{comment.post.comments.size}</span>".html_safe, post_path(comment.post), :title => 'ir para o post'))
      end
      content_tag(:ul, html.html_safe, :class => 'nav nav-list')    
    else
      content_tag(:h3, "Não há comentários")      
    end    
  end

end
