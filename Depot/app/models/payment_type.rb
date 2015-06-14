class PaymentType < ActiveRecord::Base
  has_many :orders
  
  validates :name, :presence => true 
  scope :sorted, lambda { payment_types("payment_types.id ASC")}
  
end
