class AddWinningToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :winning_share, :float
  end
end
