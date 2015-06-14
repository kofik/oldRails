class StoreController < ApplicationController
  skip_before_filter :authorize
  before_action :set_current_cart
  
  
  layout "application"
  
  def index
    
    sleep 1
    
    if params[:locale]
#      redirect_to(store_path, :locale => params[:locale])
    else
      @products = Product.all
      @cart = current_cart
    end
    
    if session[:counter].nil?
      @counter = 0
    else
      @counter = 1 + session[:counter]   
    end
    session[:counter] = @counter
    
    @products = Product.all
    set_current_cart
  end
  
  def show  
    redirect_to(:controller => 'carts', :action => 'show')
  end
  
  def delete  
    redirect_to line_item_path(params[:id])
  end   
    
  private
  
    def set_current_cart
      @cart = current_cart
    end
end
