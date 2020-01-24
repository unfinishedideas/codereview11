class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def authorize
    if !current_user
      flash[:alert] = "Please log in to view this page."
      redirect_to '/'
    end
  end

  def admin_access
    if !current_user
      flash[:alert] = "Please log in to view this page."
      redirect_to '/'
    elsif current_user.admin === false
      flash[:alert] = "You aren't authorized to visit that page. Admin only!"
      redirect_to '/'
    end
  end

  # # code taken from here: https://stackoverflow.com/questions/3304597/rails-redirect-two-pages-back
  # def store_location
  #   if request.post? || request.put?
  #     session[:return_to] = request.env['HTTP_REFERER']
  #   else
  #     session[:return_to] = request.request_uri
  #   end
  # end

end
