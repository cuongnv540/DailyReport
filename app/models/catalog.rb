class Catalog < ActiveRecord::Base
  attr_accessible :suggest, :title
  validates :title, presence: true, length: { maximum: 50 }
end
