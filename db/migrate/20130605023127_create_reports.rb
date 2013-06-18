class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :catalog_id
      t.string :user_id
      t.string :content
      t.string :file_name
      t.string :file_path

      t.timestamps
    end
  end
end
