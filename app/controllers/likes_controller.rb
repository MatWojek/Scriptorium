class LikesController < ApplicationController
  before_action :require_login
  before_action :set_like, only: %i[ show edit update destroy ]

  # GET /likes or /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /articles/1/likes or /articles/1/likes.json
  def create
    article = Article.find(params[:article_id])
    @like = article.likes.find_or_initialize_by(user: current_user)

    if @like.value == params[:value].to_i
      @like.destroy
      @like = Like.new
    else
      @like.value = params[:value].to_i
      @like.save
    end

    respond_to do |format|
      format.html { redirect_to article }
      format.json { render :show, status: :created, location: @like }
    end
  end

  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like.article, notice: "Like was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @like.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    article = @like.article
    @like.destroy! if @like.user == current_user

    respond_to do |format|
      format.html { redirect_to article, notice: "Like was successfully removed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.expect(like: [ :value ])
    end
end