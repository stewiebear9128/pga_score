class AddFieldsToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :end_date, :datetime
    add_column :tournaments, :purse, :float
    add_column :tournaments, :winning_share, :string
    add_column :tournaments, :float, :string
    add_column :tournaments, :venue_name, :string
    add_column :tournaments, :venue_city, :string
    add_column :tournaments, :venue_state, :string
  end
end
