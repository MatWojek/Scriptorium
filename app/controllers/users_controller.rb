class UsersController < ApplicationController
  before_action :require_login, only: %i[ edit update destroy ]
  before_action :require_admin, only: [:index]
  before_action :set_user, only: %i[ show edit update destroy ]
  layout "auth", only: %i[ new create ]
  
  # GET /users or /users.json
  def index
    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to view this page."
      return
    end

    @users = User.order(created_at: :desc)
  end

  # GET /users/1 or /users/1.json
  def show
    @articles = @user.articles.order(created_at: :desc)
    @comments = @user.comments.includes(:article).order(created_at: :desc).limit(10)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        AuditLog.record(action: "user_created", user: @user, target: @user, ip: request.remote_ip)
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @user.errors, status: :unprocessable_content }
      end
    end
  rescue ActiveRecord::RecordNotUnique
    @user.errors.add(:email, "is already registered")
    render :new, status: :uprocessable_content
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        AuditLog.record(action: "user_updated", user: current_user, target: @user, ip: request.remote_ip)
        format.html { redirect_to @user, notice: "User was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @user.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      AuditLog.record(action: "user_deleted", user: current_user, target: @user, ip: request.remote_ip, details: @user.username)
      format.html { redirect_to users_path, notice: "User was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.expect(user: 
        [ 
          :username, 
          :email, 
          :password, 
          :password_confirmation, 
          :first_name, 
          :last_name, 
          :bio, 
          :role_id, 
          :avatar, 
          :language_id,
          :avatar, 
        ]
      )
    end
end
