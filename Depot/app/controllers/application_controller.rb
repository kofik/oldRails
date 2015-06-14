class ApplicationController < ActionController::Base
 before_filter :set_i18n_locale_from_params
# before_filter :set_language
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authorize
  
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' } 
  respond_to :html, :js, :json


  protected
  
    def set_i18n_locale_from_params 
      if params[:set_locale]
        if I18n.available_locales.include?(params[:set_locale].to_sym) 
          I18n.locale = params[:set_locale]
        else
          flash.now[:notice] = 
               "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def default_url_options
      { :locale => I18n.locale }
    end
    
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, :notice => "Please log in"
      end 
    end

  private
    def set_language
       I18n.locale = 'en' 
    end
    
      
    def current_cart
      cart = Cart.find(session[:cart_id])
      cart
    rescue ActiveRecord::RecordNotFound
        cart = Cart.create
        session[:cart_id] = cart.id
        cart
    end
end
