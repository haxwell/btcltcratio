class AddOpenToCachedPubtickers < ActiveRecord::Migration
  def change
    add_column :cached_pubtickers, :open, :float
  end
end
