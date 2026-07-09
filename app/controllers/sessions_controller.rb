class SessionsController < ApplicationController
  layout "auth"
  
  def new
  end

  def create
    user = User.find_by(email: params[:email]&.downcase)

    if user&.banned?
      flash.now[:alert] = "This account has been suspended."
      render :new, status: :forbidden
    elsif user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Zalogowano pomyślnie"
    else
      flash.now[:alert] = "Nieprawidłowy email lub hasło"
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Wylogowano"
  end
end