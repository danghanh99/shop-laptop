class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :quantity
      t.integer :ram
      t.integer :memory
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
