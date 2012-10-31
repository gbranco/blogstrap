#coding : utf-8
class Category < ActiveRecord::Base
  
  attr_accessible :name, :situation

  validates_presence_of :name, :message => 'Campo obrigatório'
  validates_length_of   :name, :in => 3..50, :message => 'Deve ter entre 3 e 50 caracteres'
  has_many :posts

  scope :actived?, where(:situation => true) 
  scope :last_five, where(:situation => true).limit(5).order('id DESC')

  def self.search(search)
    unless search.nil? || search.empty?
      where('name LIKE ?',"%#{search}%").order("#{$order_by} #{$ordem}")
    else
      order("#{$order_by} #{$ordem}")
    end
  end

  def to_param
    "#{id}-#{slug}"
  end

protected

  def slug
    name.parameterize
  end

end

