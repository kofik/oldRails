module ApplicationHelper

  def set_checkout
    @checkout = button_to t('cart.checkout'), new_order_url, :method=> :get, :id => 'button_id', :remote => true,
                data: { disable_with: t('cart.checkout') }
  end
  
  def set_empty_cart
     @empty_cart = button_to t('cart.empty-cart'), cart_path(:id => @cart.id), :method => :delete, data: { confirm: t('cart.confirmation'), 
       disable_with: t('cart.empty-cart') }
  end

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
       attributes["style"] = "display: none;"
    else
       attributes["style"] = "display: inline;"
    end
    content_tag("div", attributes, &block)
  end
end
