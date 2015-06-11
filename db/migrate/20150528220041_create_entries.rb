class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :pool_owner
      t.float :current_payoff
      t.integer :current_place
      t.integer :golfer_flex
      t.integer :golfer_d
      t.integer :golfer_c
      t.integer :golfer_b
      t.integer :golfer_a
      t.integer :pool_id

      t.timestamps

    end
  end
end
