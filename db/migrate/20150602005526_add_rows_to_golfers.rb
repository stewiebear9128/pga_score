class AddRowsToGolfers < ActiveRecord::Migration
  def change
    add_column :golfers, :lastname, :string
    add_column :golfers, :height, :integer
    add_column :golfers, :weight, :integer
    add_column :golfers, :birthday, :date
    add_column :golfers, :country, :string
    add_column :golfers, :college, :string
    add_column :golfers, :birthplace, :string
    add_column :golfers, :turned_pro, :integer
  end
end
