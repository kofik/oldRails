class Notifier < ActionMailer::Base
  default :from => "cromanon2012@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)
    
    @order = order
    attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")   
    mail :to => @order.email, :subject => 'Pragmatic Store Order Confirmation'
    
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped(order)
    
    @order = order
    @greeting = "Hi"

    mail :to => @order.mail, :subject => 'Your order Number #{@order.id} has been shipped'
    sent_on  Time.now
  end
end
