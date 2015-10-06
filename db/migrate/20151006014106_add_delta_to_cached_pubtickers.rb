class AddDeltaToCachedPubtickers < ActiveRecord::Migration
  def change
    add_column :cached_pubtickers, :delta, :float
  end
end
