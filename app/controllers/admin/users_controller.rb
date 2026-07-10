module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:show, :edit, :update, :destroy, :ban]

    def index
      @users = User.order(created_at: :desc)

      @users = @users.where("username LIKE :q OR email LIKE :q", q: "%#{params[:q]}%") if params[:q].present?
      @users = @users.where(role_id: params[:role_id]) if params[:role_id].present?

      case params[:status]
      when "banned"
        @users = @users.where(banned: true)
      when "admin"
        @users = @users.where(admin: true)
      end

      case params[:sort]
      when "reputation"
        @users = @users.sort_by(&:reputation).reverse
      when "oldest"
        @users = @users.reorder(created_at: :asc)
      end
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

       AuditLog.record(
        action: "user_#{status}",
        user: current_user,
        target: @user,
        ip: request.remote_ip
      )

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