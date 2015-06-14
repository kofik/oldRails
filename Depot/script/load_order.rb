#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
#---
# Excerpted from "Agile Web Development with Rails, 4rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
Order.transaction do
  1.upto(100) do |i|
    Order.create(:name => "Customer #{i}", :address => "#{i} Main Street",
      :email => "customer-#{i}@example.com", :pay_type => "Check")
    
      Cart.transaction do  
        cart = Cart.create
      end
      LineItem.transaction do
        for p in Product
          LineItem.create(:product_id => p.id, :cart_id => cart.id, :quantity => 1, :order_id => 1, :price => p.price)
        end
      end 
    cart = nil
     
  end
end
