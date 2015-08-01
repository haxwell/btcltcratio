class CreateCachedPubtickers < ActiveRecord::Migration
  def change
    create_table :cached_pubtickers do |t|
      t.string :ticker_symbol_a
      t.string :ticker_symbol_b
      t.float :high
      t.float :low
      t.float :avg
      t.float :period_begin
      t.float :period_end
      t.integer :timeperiod

      t.timestamps null: false
    end
  end
end
