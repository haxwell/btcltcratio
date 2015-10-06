class DropLtcPubtickersTable < ActiveRecord::Migration
  def change
      drop_table :ltcpubtickers
  end
end
