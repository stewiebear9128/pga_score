class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.datetime :start_time
      t.string :key
      t.string :name

      t.timestamps

    end
  end
end
