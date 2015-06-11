class CreateGolferResults < ActiveRecord::Migration
  def change
    create_table :golfer_results do |t|
      t.float :current_payout
      t.float :total_score
      t.integer :current_place
      t.integer :tournament_id
      t.integer :golfer_id

      t.timestamps

    end
  end
end
