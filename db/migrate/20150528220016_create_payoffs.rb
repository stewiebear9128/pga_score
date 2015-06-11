class CreatePayoffs < ActiveRecord::Migration
  def change
    create_table :payoffs do |t|
      t.float :payout
      t.integer :place
      t.string :tournament_id

      t.timestamps

    end
  end
end
