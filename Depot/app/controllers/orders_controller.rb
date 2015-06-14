class OrdersController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  sleep 1
  
  # GET /orders
  # GET /orders.json
  def index
#    @orders = Order.all
    @orders = Order.paginate :page => params[:page], :order => 'created_at desc', :per_page => 10
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @product = Product.order(params[:id])
    @cart = Cart.find_by_id(session[:cart_id])
    @line_item = LineItem.where(:cart_id => session[:cart_id])

    respond_to do |format|
      format.html
      format.atom
      format.xml { render :xml => @product.to_xml(:include => :orders)  }
      format.json
    end    
    
  end

  # GET /orders/new
  def new
    
    @cart = current_cart
    if @cart.line_items.empty?
      flash[:notice] = "Your cart is empty"
      redirect_to(controller: 'store', action: 'index' )
      return
    end

    @order = Order.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.js   # new.js.erb 
      
#      format.json { render controller: 'store', action: 'index', status: :created, location: @order }
    end     
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find_by_id(params[:id])
    
    @cart = Cart.find_by_id(session[:cart_id])
    @line_item = LineItem.where(:cart_id => session[:cart_id])
  end

  # POST /orders
  # POST /orders.json
  def create
    
    @order = Order.new(order_params)
    
    respond_to do |format|
      if @order.save
        
        @order.add_line_items_from_cart(current_cart, @order.id)

        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        
        Notifier.order_received(@order).deliver
         
        flash[:notice] =  'Thank you for your order.' 
            
        format.html { redirect_to(controller: 'store', action: 'index') }
#            format.html { render action: 'show', :id => @order.id ,notice: 'Verify your information' }
        format.json { render controller: 'order', action: 'show', status: :created, location: @order }
      else
        flash[:notice] =  'Cart is empty.'
        format.html { redirect_to(controller: 'store', action: 'index') }
#            format.html { redirect_to(controller: 'store', action: 'index' , notice: 'Cart is empty') }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
      
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order = Order.find(params[:id])
    
    respond_to do |format|
      if @order.update(order_params)
#      if @order.update_attributes(params[:order])
        
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])

    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :payment_type_id)
    end
end
