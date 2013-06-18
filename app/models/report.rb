class Report < ActiveRecord::Base
  attr_accessible :catalog_id, :content, :file_name, :file_path, :user_id
  belongs_to :user

  validates :content, presence: true, length: { maximum: 2000 }
  validates :user_id, presence: true
  validates :catalog_id, presence: true

  default_scope order: 'reports.created_at DESC'


  def self.to_csv(options = {})
  	CSV.generate(options) do |csv|
    csv << column_names
    all.each do |report|
      csv << report.attributes.values_at(*column_names)
    end
  end
end

end
