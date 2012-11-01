#coding : utf-8
class User < ActiveRecord::Base

  belongs_to :role
  has_many :posts, :class_name => 'Post', :foreign_key => 'author_id'
  after_create :notification_user

  def is_role?(role)
    self.role.name.to_sym.eql?(role)
  end

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role_id, :situation
  # attr_accessible :title, :body

  with_options :presence => true do |validation|
    validation.with_options :uniqueness => true do |validation|
      validation.validates :name
      validation.validates :email
    end
    validation.validates :password
    validation.validates :role_id
  end
  
  validates_confirmation_of :password
  
  def self.search(search)
    unless search.nil? || search.empty?
      where('name LIKE ?',"%#{search}%").order("#{$order_by} #{$ordem}")
    else
      order("#{$order_by} #{$ordem}")
    end
  end

protected
  
  def notification_user
    NotificationMailer.notify_new_account(self).deliver
  end

end

