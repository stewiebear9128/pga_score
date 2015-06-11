class CreateGolfers < ActiveRecord::Migration
  def change
    create_table :golfers do |t|
      t.string :picture
      t.string :name
      t.string :key

      t.timestamps

    end
  end
end
