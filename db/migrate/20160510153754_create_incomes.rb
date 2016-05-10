class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.integer :user_id
      t.integer :category_id
      t.date    :date
      t.integer :amount
      t.boolean :planned, default: false

      t.timestamps null: false
    end

    add_index :incomes, :user_id
  end
end
