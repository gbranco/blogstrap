#coding : utf-8
class Post < ActiveRecord::Base
  attr_accessible :content, :name, :published_at,
                  :situation, :author_id, :category_id,
                  :archive_ids, :abstract



  has_and_belongs_to_many :archives
  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'
  belongs_to :category
  has_many :comments, :dependent => :destroy

  scope :actived?, where(:situation => true)
  scope :last_five, where(:situation => true).limit(5).order('id DESC')

  with_options :presence => {:message => 'Campo Obrigatório'} do |v| #já sabe que tem que ser :presence => true
    v.validates :name, :uniqueness => { :message => 'Já existe um post com esse título' }
    v.validates :abstract, :length => { :maximum => 250 }
    v.validates :content
    v.validates :published_at
    v.validates :author_id
    v.validates :category_id
  end


  def self.search(search)
    unless search.nil? || search.empty?
      joins(:category).where('posts.name LIKE :t or posts.content LIKE :t or categories.name LIKE :t',:t => "%#{search}%").order("#{$order_by} #{$ordem}")
    else
      order("#{$order_by} #{$ordem}")
    end
  end

  def self.search_in_blog(params)
    if params[:category_id]
      where(:category_id => params[:category_id]).order(:id => :desc).paginate(:per_page => 5,:page => params[:page])
    else
      actived?.search(params[:search]).paginate(:per_page => 5,:page => params[:page])
    end
  end

  def create_date
    created_at.strftime("%d/%m/%y")
  end

  def create_date_and_hour
    created_at.strftime("%d/%m/%y  %H:%M")
  end

  def to_param
    "#{id}-#{generate_slug}"
  end

protected

  def generate_slug
    name.parameterize
  end

end

