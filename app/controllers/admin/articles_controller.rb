module Admin
  class ArticlesController < BaseController
    def index
      @articles = Article.order(created_at: :desc)
    end

    def destroy
      Article.find(params[:id]).destroy!
      redirect_to admin_articles_path, notice: "Article deleted."
    end
  end
end