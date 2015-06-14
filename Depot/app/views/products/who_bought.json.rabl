collection @order
attributes :name, :address, :email, :pay_type, :updated_at
child :line_items do
  attributes :quantity, :price
  child :product do
    attributes :title, :description
  end
end