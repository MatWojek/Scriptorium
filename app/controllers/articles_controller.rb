class ArticlesController < ApplicationController
  before_action :require_login, only: %i[ new create edit update destroy ]
  before_action :set_article, only: %i[ show edit update destroy export_pdf ]
  
  # GET /articles or /articles.json
  def index
    @articles = Article.all

    @articles = @articles.where("title LIKE ?", "%#{params[:q]}%") if params[:q].present?
    @articles = @articles.where(category_id: params[:category_id]) if params[:category_id].present?
    @articles = @articles.where(language_id: params[:language_id]) if params[:language_id].present?

    if params[:tag].present? 
      tag = Tag.find_by(name: params[:tag].downcase)
      @articles = tag ? @articles.joins(:article_tags).where(article_tags: {tag_id: tag.id}) : @articles.none
    end 

    case params[:sort]
    when "most_liked"
      @articles = @articles.left_joins(:likes).group(:id).order(Arel.sql("COALESCE(SUM(likes.value), 0) DESC"))
    else
      @articles = @articles.order(created_at: :desc)
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = current_user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        AuditLog.record(action: "article_created", user: current_user, target: @article, ip: request.remote_ip)
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @article.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        AuditLog.record(action: "article_updated", user: current_user, target: @article, ip: request.remote_ip)
        format.html { redirect_to @article, notice: "Article was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @article.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      AuditLog.record(action: "article_deleted", user: current_user, target: @article, ip: request.remote_ip, details: @article.title)
      format.html { redirect_to articles_path, notice: "Article was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def mine
    @articles = current_user.articles.order(created_at: :desc)
  end

  def export_pdf
    pdf_data = ArticlePdfExporter.new(@article).generate

    send_data pdf_data, 
      filename: "#{@article.title.parameterize}.pdf",
      type: "application/pdf", 
      disposition: "inline" # it's for open in another page
      # "attachment" - for download
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.expect(article: [ :title, :content, :category_id, :language_id ])
    end
end
