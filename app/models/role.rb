class Role < ActiveRecord::Base
  attr_accessible :name, :situation

  has_many :users
end
