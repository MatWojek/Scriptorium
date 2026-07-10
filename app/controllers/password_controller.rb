class PasswordsController < ApplicationController
  before_action :require_login

  def edit
  end

  def update
    if current_user.authenticate(params[:current_password])
      if current_user.update(password_params)
        redirect_to user_path(current_user), notice: "Password updated."
      else
        render :edit, status: :unprocessable_content
      end
    else
      current_user.errors.add(:current_password, "is incorrect")
      render :edit, status: :unprocessable_content
    end
  end

  private

  def password_params
    params.expect(user: [ :password, :password_confirmation ])
  end
end