require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @request.env['HTTP_REFERER'] = 'http://test.host/store'
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, line_item: { cart_id: @line_item.cart_id, product_id: @line_item.product_id }
#      post :create, :product_id => products(:ruby).id
      post :create, :product_id => products(:ruby)
    end

#    assert_redirected_to line_item_path(assigns(:line_item))
#    assert_redirected_to cart_path(assigns(:line_item).cart)
    assert_redirected_to store_path
  end

  test "should create line_item via ajax" do 
    assert_difference('LineItem.count') do
      xhr :post, :create, :product_id => products(:ruby).id
    end
    assert_response :success
    assert_select 'tr#current_item', /Programming Ruby 1.9/
  end

  test "should show line_item" do
    get :show, id: @line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item
    assert_response :success
  end

  test "should update line_item" do
    patch :update, id: @line_item, line_item: { cart_id: @line_item.cart_id, product_id: @line_item.product_id }
#    assert_redirected_to line_item_path(assigns(:line_item))
    assert_redirected_to store_path
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: @line_item
    end

#    assert_redirected_to line_items_path
    assert_redirected_to store_path    
  end
end
