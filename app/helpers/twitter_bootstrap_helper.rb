#encoding : utf-8
module TwitterBootstrapHelper

    class BootstrapLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
      protected

      def html_container(html)
        tag :div, tag(:ul, html), container_attributes
      end

      def page_number(page)
        tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
      end

      def gap
        tag :li, link(super, '#'), :class => 'disabled'
      end

      def previous_or_next_page(page, text, classname)
        tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
      end
    end

    def page_navigation_links(pages)
      will_paginate(pages, :class => 'pagination pagination-left', :inner_window => 0, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr;'.html_safe, :next_label => '&rarr;'.html_safe)
    end

  #form helpers

  #input and label for field in form
  def form_field_control_label_and_input(object, field, input, options = {})
    label_name = options[:label_name].nil? ? field.to_s.camelize : options[:label_name]
    content_tag(:div,:class => 'control-group') do
      label(object, field, label_name,:class => 'control-label') +
      content_tag(:div, input, :class => 'controls')
    end                
  end

  def show_select(form, objetos, options = {})
    clazz = objetos.first.class.to_s.downcase.underscore
    field = "#{clazz}_id".to_sym
    label_name = options[:label_name].nil? ? field.to_s.camelize : options[:label_name]
    label(clazz, field, label_name,:class => 'control-label') +
    content_tag(:div, :class => 'control-group') do 
      content_tag(:div,form.collection_select(field, objetos, :id, :name, :prompt => 'Selecione...'), :class => 'controls') 
    end
  end

  #submit and back buttons in create forms
  def submit_and_back_buttons(back_route, options = {})
    label_name = options[:label_name] unless options[:label_name].nil? || options[:label_name].blank?
    content_tag(:div, :class => 'control-group') do
      content_tag(:div,
                  tag(:input, :type => 'submit', :class => 'btn', :value => label_name) +
                  link_to("<i class=\"icon-white icon-arrow-left\"></i> Voltar".html_safe, back_route, :class => 'btn btn-inverse',:title => 'voltar'),
                  :class => 'controls btn-group')
    end
  end

  #submit and back buttons in edit forms
  def back_button(back_route)
    link_to("<i class=\"icon-white icon-arrow-left\"></i> Voltar".html_safe, back_route, :class => 'btn btn-inverse',:title => 'voltar')
  end

  #files in show pages
  def show_field_value(column_name, column_value)
    content_tag(:tr) do 
      content_tag(:td, t("#{column_name}")) +
      content_tag(:td, column_value)
    end  
  end

  #create a menu in nav-menu
  def nav_menu(nav_class = 'nav', &block)
    content_tag(:ul, :class => nav_class) do 
      capture(&block) #yield
    end
  end

  #create a menu item link like'Categories'
  def nav_menu_item(menu_label, &block)
    
    icon = case menu_label
    when 'category' ; "<i class='icon-tag'></i>"
    when 'user' ; "<i class='icon-user'></i>"
    when 'post' ; "<i class='icon-font'></i>"
    when 'comment' ; "<i class='icon-comment'></i>"
    when 'archive' ; "<i class='icon-upload'></i>"
    end        

    menu_label = t("activerecord.models.#{menu_label}")
    content_tag(:li, :class => 'dropdown') do 
      link_to("#{icon} #{menu_label} <b class='caret'></b>".html_safe, '#', :class => 'dropdown-toggle', :data => { :toggle => 'dropdown' }) +
      content_tag(:ul, :class => 'dropdown-menu') do 
          capture(&block)#yield
      end
    end
  end

  #create a sub_menu link like 'List Categories'
  def nav_sub_menu_item(sub_menu_label, permission, route = '#', title = '', options = {})
    model_name = route.gsub( /(new|path|admin|_|\/)/, '').strip.capitalize.singularize.constantize
    controller = route.gsub(/(new|path|admin|_|\/)/, '').strip.downcase.underscore.pluralize
    sub_menu_label = t("activerecord.models.#{sub_menu_label}")
    action, sub_menu_label = permission.eql?(:create) ? [:new, "Cadastrar #{sub_menu_label}"] : [:index, "Listar #{sub_menu_label}"]
    new_route  = { :controller => "admin/#{controller}", :action => action }
    content_tag(:li, link_to(sub_menu_label, new_route, :title => title)) if can? permission, model_name
  end

  #when the list is empty...
  def alert_list_empty
    content_tag(:div,:class => 'alert') do 
      content_tag(:button,'x',:class => 'close', data: { dismiss: "alert"})
      content_tag(:h3, 'Não há registros')
    end
  end



  #form search on index pages

  #NEED FIX !
  def form_search(route_for_new, route_for_search, title)
    route_for_new = route_for_new unless route_for_new.nil?
    title         = title unless title.nil?
    render 'admin/shared/form_search', :route_for_new => route_for_new, :route_for_search => route_for_search, :title => title
  end

  #show actions for register link 'edit, show, delete, details'
  def show_actions(objeto, show_all_menus = true, options = {})
    objeto_for_route = objeto.class.to_s.downcase.underscore.pluralize
    html = %()
    if show_all_menus
      html << link_to("<i class=\"icon-list-alt\"></i> Detalhes".html_safe,"/admin/#{objeto_for_route}/#{objeto.id}",:class => 'btn')
      html << link_to("<i class=\"icon-refresh\"></i> Editar".html_safe, "/admin/#{objeto_for_route}/#{objeto.id}/edit",:class => 'btn')
      html << link_to("<i class=\"icon-trash\"></i> Excluir".html_safe, "/admin/#{objeto_for_route}/#{objeto.id}", method: :delete, data: { confirm: 'Deseja Realmente excluir ?' },:class => 'btn')
    else
      actions = options[:actions] unless options[:actions].nil?
      if actions.kind_of? Array
        actions.each { |action| html << build_action_link(action, objeto) }
      else
        html << build_action_link(actions, objeto)
      end
    end
    content_tag(:td, html.html_safe, :class => 'actions btn-group') 
  end

  def build_action_link(action, objeto)
    case action
      when 'show'   ; link_to("<i class=\"icon-list-alt\"></i> Detalhes".html_safe,"/admin/#{objeto.class.to_s.downcase.underscore.pluralize}/#{objeto.id}",:class => 'btn')
      when 'edit'   ; link_to("<i class=\"icon-refresh\"></i> Editar".html_safe, "/admin/#{objeto.class.to_s.downcase.underscore.pluralize}/#{objeto.id}/edit",:class => 'btn')
      when 'delete' ; link_to("<i class=\"icon-trash\"></i> Excluir".html_safe, "/admin/#{objeto.class.to_s.downcase.underscore.pluralize}/#{objeto.id}", method: :delete, data: { confirm: 'Deseja Realmente excluir ?' },:class => 'btn')
    end 
  end

  #show flash message on top with de message dãr
  def show_flash(flash)   
    unless flash.nil? || flash.empty?
      clazz = case flash.first.first
        when :notice ; 'alert alert-success'
        when :alert ; 'alert alert-error'
        when :warning ; 'alert alert-warning'
      end
      content_tag(:div, :class => clazz) do 
        content_tag(:button,'x',:class => 'close', data: { dismiss: "alert"}) + 
        content_tag(:h3, flash.first.second)
      end
    end     
  
  end

  #create a link to situation, using pjax to not refresh the page
  #NEED REFACTORY !
  def link_to_situation(objeto)
    html = %()
 
    if objeto.respond_to? :situation
      if objeto.situation
        html << link_to("<i class=\"icon-remove\"></i> Desativar".html_safe,{:objeto_id => objeto.id, :model_name => objeto.class.to_s},
              {:alt => "ação : desativar",
              :title => "ação desativar registro",
              :class => "btn btn-danger"})
      else
        html << link_to("<i class=\"icon-ok\"></i> Ativar".html_safe, {:objeto_id => objeto.id, :model_name => objeto.class.to_s},
              {:alt => "ação : ativar",
              :title => "ação ativar registro",
              :class => "btn btn-success"})
      end
    end
    html.html_safe
  end

  #show ordenation field on the attr
  #NEED FIX
  def show_ordenation(field)
    content_tag(:span, :class => 'pull-right') do 
      link_to("<i class='icon-arrow-up'></i>".html_safe, {:order_by => field, :ordem => 'ASC'}, :class => 'ordem_asc') +
      link_to("&nbsp;<i class='icon-arrow-down'></i>".html_safe, {:order_by => field, :order => 'DESC'}, :class => 'ordem_desc')
    end
  end

  #show how many itens per page using pjax to not reload the page
  def itens_per_page
    content_tag(:div, :class => 'btn-group', :style => 'display:inline-block;') do 
      link_to("por página <span class='caret'></span>".html_safe, 'javascript:void(0)', :class => 'btn dropdown-toggle',:data => {:toggle => 'dropdown'}) +
      content_tag(:ul, :class => 'dropdown-menu') do 
        content_tag(:li, link_to('3', {:per_page => 3})) +
        content_tag(:li, link_to('5', {:per_page => 5})) +
        content_tag(:li, link_to('10', {:per_page => 10})) + 
        content_tag(:li, link_to('20', {:per_page => 20}))  
      end
    end
  end

  #list all register in index page
  def table_list(objetos, show_all_actions = true, options = {})
    render :partial => '/admin/shared/table_list', :locals => { :objetos => objetos, :show_all_actions => show_all_actions, :options => options }
  end

  #list each archive for the type passed
  def archives_for_type(type, post)
    archives = Archive.all.select { |archive| archive if archive.same_type?(type) }
    images_types = %w(jpg png gif jpeg)
    files_types  = %w(rar zip pdf txt)
    html = %()

    if images_types.include? type 
      archives.each do |archive|
        html << build_structure(archive, type, post)
      end
    elsif files_types.include? type
      archives.each do |archive| 
        html << build_structure(archive, type, post)
      end
    end
    content_tag(:ul, html.html_safe, :class => 'thumbnails')
  end

  def build_structure(archive, type, post)
    case type
    when /jpg|jpeg|png|gif/ ; build_li_for_archive(archive, archive.image.url, 'picture', post, false)
    when /rar|zip/ ; build_li_for_archive(archive, 'rar.png', 'files', post) 
    when 'pdf' ; build_li_for_archive(archive, 'pdf.png', 'files', post) 
    when 'txt' ; build_li_for_archive(archive, 'txt.png', 'files', post)
    end 
  end

  def build_li_for_archive(archive, icon_url, clazz, post, show_name = true)
    content_tag(:li, :class => "thumbnail #{clazz}") do
      check_box_tag('post[archive_ids][]', archive.id, archive.posts.include?(post)) +
      "<span>#{archive.name if show_name} </span> #{image_tag(icon_url, :title => archive.name, :size => '50x50')}".html_safe
    end
  end

  #show thumbnail for assets in admin/posts#show
  def show_assets_for_post(post)
    html = %()
    unless post.archives.empty?
      html << content_tag(:h3, "<br />&nbsp;&nbsp;&nbsp; Assets Relacionadas : <hr /><br/>".html_safe)
      post.archives.each { |archive| html << build_asset_for_post(archive, archive.type) }
    else
      html << content_tag(:h3, "<br />&nbsp;&nbsp;&nbsp; Sem Assets !".html_safe)
    end
    content_tag(:ul, html.html_safe, :class => 'thumbnails')
  end

  def build_asset_for_post(archive, type)
    case type
    when /jpg|jpeg|png|gif/ ; content_tag(:li, image_tag(archive.image.thumb.url) ,:class => 'thumbnail show', :title => archive.name)
    when /rar|zip/ ; content_tag(:li, image_tag('rar.png') ,:class => 'thumbnail show', :title => archive.name)
    when 'pdf' ; content_tag(:li, image_tag('pdf.png') ,:class => 'thumbnail show', :title => archive.name)
    when 'txt' ; content_tag(:li, image_tag('txt.png') ,:class => 'thumbnail show', :title => archive.name)
    end 
  end

  #show comments in post/show
  def show_comments_for_post(comments)
    
    html =  %()
    unless comments.empty?
      html << content_tag(:h3, "<br />&nbsp;&nbsp;&nbsp; Comentários Relacionadas : #{comments.size}<hr /><br/>".html_safe) 
      comments.each { |comment| html << render(:partial => '/admin/comments/comment', :locals => { :comment => comment }) }
    else
      html << content_tag(:h3, "<br />&nbsp;&nbsp;&nbsp; Sem comentários !".html_safe)
    end #end unless

    html.html_safe
  end

  def show_status_for_comment(comment)
    comment.situation ? link_to('Desaprovar',admin_post_comment_path(comment.post, comment), :method => :put, :class => 'btn btn-mini btn-danger', :remote => true) : link_to('Aprovar', admin_post_comment_path(comment.post, comment), :method => :put, :class => 'btn btn-mini btn-success', :remote => true)
  end


  #show assets by ext in posts/id
  def assets_for_post(assets)
    html, files, images = %(), %(), %()
    unless assets.empty?
      assets.each do |asset|
        if asset.same_type?('jpg') || asset.same_type?('png') || asset.same_type?('gif') || asset.same_type?('jpeg')   
          images << build_list_assets_by_type_to_post(asset)
        elsif asset.same_type?('rar') || asset.same_type?('zip') || asset.same_type?('pdf') || asset.same_type?('txt')
          files << build_list_assets_by_type_to_post(asset, asset.type)
        end
      end      
    end
    html << content_tag(:h3, "Galeria de imagens")
    html << content_tag(:ul, images.html_safe, :class => 'thumbnails gallery') unless images.empty?
    html << "<hr />".html_safe
    html << content_tag(:h3, "Arquivos relacionados")
    html << content_tag(:ul, files.html_safe, :class => 'thumbnails') unless files.empty?
    html.html_safe
  end

  def build_list_assets_by_type_to_post(asset, type = nil)
    type.nil? ? content_tag(:li, link_to(image_tag(asset.image.thumb.url, :alt => asset.name), asset.image.url, :class => 'zoom') , :class => 'thumbnail show_public') : content_tag(:li, "#{image_tag("#{type}.png", :alt => asset.name)} #{link_to(asset.name, asset.image.url, :target => '_blank', :title => 'clique e faça o download', :class => 'download')}".html_safe, :class => 'thumbnail file_download')  
  end


end
