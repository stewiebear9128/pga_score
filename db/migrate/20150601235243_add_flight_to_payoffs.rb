class AddFlightToPayoffs < ActiveRecord::Migration
  def change
    add_column :payoffs, :flight, :integer
  end
end
