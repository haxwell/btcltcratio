class ChangePubtickersTimestampToTypeString < ActiveRecord::Migration
  def change
      change_column :pubtickers, :timestamp, :string
  end
end
