module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:show, :edit, :update, :destroy, :ban]

    def index
      @users = User.order(created_at: :desc)
    end

    def show
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: "User updated."
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @user.destroy!
      redirect_to admin_users_path, notice: "User deleted."
    end

    def ban
      @user.update(banned: !@user.banned)
      status = @user.banned? ? "banned" : "unbanned"
      redirect_to admin_users_path, notice: "User #{@user.username} has been #{status}."
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.expect(user: [ :username, :email, :first_name, :last_name, :bio, :role_id, :admin ])
    end
  end
end