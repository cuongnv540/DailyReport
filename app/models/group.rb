class Group < ActiveRecord::Base
  attr_accessible :group_id, :name
  validates :group_id, presence: true, uniqueness: { case_sensitive: false }
end