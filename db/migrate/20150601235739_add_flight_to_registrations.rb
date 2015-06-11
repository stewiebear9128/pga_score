class AddFlightToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :flight, :integer
  end
end
