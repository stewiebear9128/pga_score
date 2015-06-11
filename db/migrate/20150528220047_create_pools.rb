class CreatePools < ActiveRecord::Migration
  def change
    create_table :pools do |t|
      t.integer :tournament_id
      t.integer :owner_id
      t.string :name

      t.timestamps

    end
  end
end
