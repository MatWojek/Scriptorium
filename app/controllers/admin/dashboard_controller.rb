module Admin
  class DashboardController < BaseController
    def index
      @articles_count = Article.count
      @comments_count = Comment.count
      @users_count = User.count
    end
  end
end