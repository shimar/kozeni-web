class CreateOutgoes < ActiveRecord::Migration
  def change
    create_table :outgoes do |t|
      t.integer :user_id
      t.integer :category_id
      t.date    :date
      t.integer :amount
      t.boolean :planned

      t.timestamps null: false
    end

    add_index :outgoes, :user_id
  end
end
