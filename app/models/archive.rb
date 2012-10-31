class Archive < ActiveRecord::Base
	include Rails.application.routes.url_helpers
	has_and_belongs_to_many :posts
  attr_accessible :image
  mount_uploader :image, ArchiveUploader

  validates :image, :presence => true

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
      "name" => read_attribute(:image),
      "size" => image.size,
      "url" => image.url,
      "thumbnail_url" => image.thumb.url,
      "delete_url" => admin_archive_path(self),
      "delete_type" => "DELETE" 
    }
  end

  def self.archive_types
    Archive.all.map { |archive| archive.image.to_s.downcase.split('.').last }.uniq
  end

  def name
    self.image.to_s.split('/').last
  end

  def same_type?(type)
    self.image.to_s.downcase.split('.').last.eql?(type) 
  end

  def type
    self.image.to_s.downcase.split('.').last
  end

end
