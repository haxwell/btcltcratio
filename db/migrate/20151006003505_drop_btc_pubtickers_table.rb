class DropBtcPubtickersTable < ActiveRecord::Migration
  def change
      drop_table :btcpubtickers
  end
end
