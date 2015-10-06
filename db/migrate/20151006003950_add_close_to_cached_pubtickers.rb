class AddCloseToCachedPubtickers < ActiveRecord::Migration
  def change
    add_column :cached_pubtickers, :close, :float
  end
end
