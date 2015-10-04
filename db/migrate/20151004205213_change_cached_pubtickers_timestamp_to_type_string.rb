class ChangeCachedPubtickersTimestampToTypeString < ActiveRecord::Migration
  def change
      change_column :cached_pubtickers, :period_begin, :string
      change_column :cached_pubtickers, :period_end, :string
  end
end
