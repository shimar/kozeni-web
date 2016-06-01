class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.string :type
      t.integer :user_id
      t.date :date
      t.integer :income
      t.integer :outgo

      t.timestamps null: false
    end
  end
end
