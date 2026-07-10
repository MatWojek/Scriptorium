module Admin
  class CommentsController < BaseController
    def index
      @comments = Comment.includes(:user, :article).order(created_at: :desc)

      @comments = @comments.where("content LIKE ?", "%#{params[:q]}%") if params[:q].present?
      @comments = @comments.where(user_id: params[:user_id]) if params[:user_id].present?
      @comments = @comments.where(ip_address: params[:ip]) if params[:ip].present?

      case params[:sort]
      when "oldest"
        @comments = @comments.reorder(created_at: :asc)
      when "most_liked"
        @comments = @comments.left_joins(:ratings).group(:id).order(Arel.sql("COALESCE(SUM(comment_ratings.value), 0) DESC"))
      end
    end

    def destroy
      Comment.find(params[:id]).destroy!
      redirect_to admin_comments_path, notice: "Comment deleted."
    end

    def ban
      comment = Comment.find(params[:id])
      BannedIp.find_or_create_by(ip_address: comment.ip_address)

      AuditLog.record(action: "login", user: user, ip: request.remote_ip)

      redirect_to admin_comments_path, notice: "IP #{comment.ip_address} has been banned."
    end
  end
end