class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.string :title
      t.string :suggest

      t.timestamps
    end
  end
end
