module Admin
  class ArticlesController < BaseController
    def index
      @articles = Article.includes(:user, :category).order(created_at: :desc)

      @articles = @articles.where("title LIKE ?", "%#{params[:q]}%") if params[:q].present?
      @articles = @articles.where(category_id: params[:category_id]) if params[:category_id].present?
      @articles = @articles.where(language_id: params[:language_id]) if params[:language_id].present?

      case params[:sort]
      when "most_liked"
        @articles = @articles.left_joins(:likes).group(:id).order(Arel.sql("COALESCE(SUM(likes.value), 0) DESC"))
      when "oldest"
        @articles = @articles.reorder(created_at: :asc)
      end
    end

    def destroy
      Article.find(params[:id]).destroy!
      redirect_to admin_articles_path, notice: "Article deleted."
    end
  end
end