class CreateWebsites < ActiveRecord::Migration[7.1]
  def change
    create_table :websites do |t|
      t.string :name
      t.string :url
      t.string :category
      t.string :description

      t.timestamps
    end
  end
end 
