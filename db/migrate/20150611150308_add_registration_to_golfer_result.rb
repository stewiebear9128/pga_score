class AddRegistrationToGolferResult < ActiveRecord::Migration
  def change
    add_column :golfer_results,:reg_id, :integer
    remove_column :golfer_results,:tournament_id, :string
    remove_column :golfer_results,:golfer_id, :string
  end
end
