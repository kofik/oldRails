require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    @update = {
      :title        =>  'Lorem Ipsum',
      :description  =>  'Widdles Are Fun!',
      :image_url    =>  'lorem.jpg',
      :price        =>  19.95
    }  
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
    post :create, product: { description: 'Widdles Are Fun!', image_url: 'lorem.jpg', price: 19.95, title: 'Lorem Ipsum' }
#    post :create, product: => @update
    end
    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { description: @product.description, image_url: @product.image_url, price: @product.price, title: @product.title }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should get product -> index" do
    get :index
    assert_response :success
    assert_select '#product_list .list_image', :minimum => 3 
    assert_select '#product_list .list_actions a', :minimum => 9
    assert_select '#product_list dt', 'Programming Ruby 1.9' 
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end
    assert_redirected_to products_path
  end
  
end
