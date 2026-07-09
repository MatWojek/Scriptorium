class ArticleTagsController < ApplicationController
  before_action :set_article_tag, only: %i[ show edit update destroy ]

  # GET /article_tags or /article_tags.json
  def index
    @article_tags = ArticleTag.all
  end

  # GET /article_tags/1 or /article_tags/1.json
  def show
  end

  # GET /article_tags/new
  def new
    @article_tag = ArticleTag.new
  end

  # GET /article_tags/1/edit
  def edit
  end

  # POST /article_tags or /article_tags.json
  def create
    @article_tag = ArticleTag.new(article_tag_params)

    respond_to do |format|
      if @article_tag.save
        format.html { redirect_to @article_tag, notice: "Article tag was successfully created." }
        format.json { render :show, status: :created, location: @article_tag }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @article_tag.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /article_tags/1 or /article_tags/1.json
  def update
    respond_to do |format|
      if @article_tag.update(article_tag_params)
        format.html { redirect_to @article_tag, notice: "Article tag was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @article_tag }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @article_tag.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /article_tags/1 or /article_tags/1.json
  def destroy
    @article_tag.destroy!

    respond_to do |format|
      format.html { redirect_to article_tags_path, notice: "Article tag was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_tag
      @article_tag = ArticleTag.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def article_tag_params
      params.expect(article_tag: [ :article_id, :tag_id ])
    end
end
