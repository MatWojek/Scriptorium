class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @article = Article.find(params[:article_id])

    @comment = @article.comments.new(comment_params)
    @comment.user = current_user if logged_in?
    @comment.ip_address = request.remote_ip 

  respond_to do |format|
    if @comment.save
      format.html { redirect_to @article, notice: "Comment was successfully created." }
      format.json { render :show, status: :created, location: @comment }
    else
      format.html { render "articles/show", status: :unprocessable_entity }
      format.json { render json: @comment.errors, status: :unprocessable_entity }
    end
  end
end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @comment.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    article = @comment.article
    @comment.destroy! if @comment.editable_by?(current_user)

    respond_to do |format|
      format.html { redirect_to comments_path, notice: "Comment was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params.expect(:id))
      redirect_to root_path, alert: "Not authorized." unless @comment.editable_by?(current_user)
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [ :content, :user_id, :article_id ])
    end
end
