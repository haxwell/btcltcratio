class AddDeltaPercentageToCachedPubtickers < ActiveRecord::Migration
  def change
    add_column :cached_pubtickers, :delta_percentage, :float
  end
end
