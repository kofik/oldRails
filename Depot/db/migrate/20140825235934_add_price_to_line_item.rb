class AddPriceToLineItem < ActiveRecord::Migration
  def up
    add_column :line_items, :price, :decimal, :precision => 8, :scale => 2
  end
  def down
    drop_column :line_items, :price
  end
end
