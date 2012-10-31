class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :company, :content, :email, :facebook, 
  								:name, :twitter, :situation, :post_id

  with_options :presence => true do |validation|
    validation.validates :name
    validation.validates :content, :length => { :maximum => 250 }
    validation.validates :post_id
    validation.validates :email, :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  end

  scope :actived?, where(:situation => true)

  scope :has_new_comments, where(:situation => false).group(:post_id)
<<<<<<< HEAD
  scope :more_commented, select('*, count(*)').group('post_id').limit(8).order('count(*) DESC')
=======
  scope :more_commented, select('*, count(*)').group('post_id').limit(8).order('count_all DESC')
>>>>>>> b47040cc6ad5882f7df5e0352d734595db94ea05

  after_create :notify_user_about_comment

  def self.search(search)
    unless search.nil? || search.empty?
      where('name LIKE ?',"%#{search}%").order("#{$order_by} #{$ordem}")
    else
      order("#{$order_by} #{$ordem}")
    end
  end

  def created_date
    self.created_at.strftime("%d/%m/%y")
  end

protected

  def notify_user_about_comment
    NotificationMailer.notify_new_comment(self).deliver
  end
  
end
