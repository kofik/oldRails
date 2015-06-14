class AlterPayType < ActiveRecord::Migration
  def up
#    rename_column("orders", "pay_type", "payment_type_id")
#    change_column("orders", "payment_type_id", :integer)
  end
  
  def down
#    change_column("orders", "payment_type_id", :string)
#    rename_column("orders", "payment_type_id", "pay_type")
  end
end
