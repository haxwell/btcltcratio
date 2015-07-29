class CreatePubtickers < ActiveRecord::Migration
  def change
    create_table :pubtickers do |t|
      t.float :mid
      t.float :bid
      t.float :ask
      t.float :last_price
      t.float :low
      t.float :high
      t.float :volume
      t.float :timestamp
      t.string :tickerSymbol

      t.timestamps null: false
    end
  end
end
