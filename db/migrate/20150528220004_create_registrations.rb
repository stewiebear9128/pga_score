class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :tournament_id
      t.integer :golfer_id

      t.timestamps

    end
  end
end
