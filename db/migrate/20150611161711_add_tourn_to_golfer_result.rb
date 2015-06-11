class AddTournToGolferResult < ActiveRecord::Migration
  def change
    add_column :golfer_results,:tournament_id, :integer
  end
end
