class LineItemsController < ApplicationController
  skip_before_filter :authorize, :only => :create
  before_action :set_line_item, only: [:verificacion, :show, :edit, :update, :destroy]
  
  layout "application"

  # GET /line_items
  # GET /line_items.json
  def index 
     
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    
  end

  # GET /line_items/new
  def new
    
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
   
  end
 
 
  # POST /line_items
  # POST /line_items.json
  def create
  # Sustituida por la linea despues de product = Pro...  
  #  @line_item = LineItem.new(line_item_params)
  
    @cart = current_cart   
    
    product = Product.find_by_id(params[:product_id].to_i)    
    
    @line_item = @cart.add_product(product, @cart)
    
    session[:counter] = 0
    @current_item = @line_item

    session[:current_item] = @current_item.id
           
    respond_to do |format|
      if @line_item.save        
        format.html { redirect_to :back }
        format.js   { @current_item }
        format.json { render action: 'show', status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    
    @cart = current_cart  
       
#    product = Product.find_by_id(@line_item.product_id)    
 
    @line_item = nil
    @line_item = LineItem.find_by_id(params[:id].to_i)
#    @line_item = @cart.upd_product(product, @cart)
            
      session[:counter] = 0
      @line_item.quantity = @line_item.quantity - 1
      @current_item = nil
      @current_item = @line_item
      
      session[:current_item] = @current_item.id    
      
      respond_to do |format| 
      
        if @line_item.update_attributes(:id => params[:id].to_i)
          
           if @line_item.quantity < 1
             delete_line_item(@line_item.id)
           end
           
           format.html { redirect_to store_path }
           format.js   { @current_item }
           format.json { head :no_content }
        else
            
           format.html { render action: 'edit' }
           format.js   { @current_item }
           format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      end     
  end
   
  # DELETE /line_items/1
  # DELETE /line_items/1.json
  
  def destroy
    
    @cart = current_cart
    @line_item = LineItem.find(params[:id])
    
    @line_item.destroy
        
    respond_to do |format|            
       
      format.html { redirect_to store_path  }
      format.js { @cart }
      format.json { head :no_content }
    end
   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params      
      params.require(:line_item).permit(:product_id, :cart_id, :quantity, :price)
    end
   
    def delete_line_item(id)
      
      line_item = LineItem.find(id)
      line_item.destroy
        
    end
end
