class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :user_id
      t.string :name

      t.timestamps null: false
    end

  add_index :categories, :user_id
  end
end
