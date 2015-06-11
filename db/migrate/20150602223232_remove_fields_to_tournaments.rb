class RemoveFieldsToTournaments < ActiveRecord::Migration
  def change
    remove_column :tournaments, :float, :string
    remove_column :tournaments, :winning_share, :string
  end
end
