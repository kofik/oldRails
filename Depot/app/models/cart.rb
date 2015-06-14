class Cart < ActiveRecord::Base
#  has_many :line_items, :dependent => :destroy
  has_many :line_items
  
  def add_product(product, cart)
      current_item = line_items.where(:product_id => product.id.to_i).where(:cart_id => cart.id).first 
      
      if ! current_item.nil?
        current_item.quantity = 1 + current_item.quantity
        current_item.price = product.price
      else
        current_item = line_items.build(:product => product)
        current_item.quantity = 1
        current_item.price = product.price
        line_items << current_item
      end
      current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
    
end
