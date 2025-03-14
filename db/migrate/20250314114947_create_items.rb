class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :url
      t.text :description
      t.decimal :price
      t.boolean :bought

      t.timestamps
    end
  end
end
