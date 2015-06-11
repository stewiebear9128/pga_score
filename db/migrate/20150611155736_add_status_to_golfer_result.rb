class AddStatusToGolferResult < ActiveRecord::Migration
  def change
    add_column :golfer_results,:status, :string
  end
end
