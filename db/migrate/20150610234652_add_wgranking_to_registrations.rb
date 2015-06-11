class AddWgrankingToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :wg_ranking, :integer
  end
end
