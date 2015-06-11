class RemoveFlightFromPayoffs < ActiveRecord::Migration
  def change
    remove_column :payoffs, :flight, :integer
  end
end
