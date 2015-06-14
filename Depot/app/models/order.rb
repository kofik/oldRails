class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  has_many :products, :through => :line_items
  belongs_to :payment_types
  
  PAYMENT_TYPES = [ 1, 2, 3, 4, 5 ]
  
  validates :name, :address, :email, :payment_type_id, :presence => true 
  validates :payment_type_id, :inclusion => PAYMENT_TYPES
  scope :sorted, lambda { order("orders.id ASC")}
 
  
  def add_line_items_from_cart(current_cart, order_id)
    
    for items in LineItem.where(:cart_id => current_cart.id)
      items.order_id = order_id
      items.update_attributes(:id => items.id)
    end   
    
  end
  
end
