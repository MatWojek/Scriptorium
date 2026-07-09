module Admin
  class CommentsController < BaseController
    def index
      @comments = Comment.includes(:user, :article).order(created_at: :desc)
    end

    def destroy
      Comment.find(params[:id]).destroy!
      redirect_to admin_comments_path, notice: "Comment deleted."
    end

    def ban
      comment = Comment.find(params[:id])
      BannedIp.find_or_create_by(ip_address: comment.ip_address)
      redirect_to admin_comments_path, notice: "IP #{comment.ip_address} has been banned."
    end
  end
end