class CreateOutgos < ActiveRecord::Migration
  def change
    create_table :outgos do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :amount
      t.boolean :planned

      t.timestamps null: false
    end

    add_index :outgos, :user_id
  end
end
