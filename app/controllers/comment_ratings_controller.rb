class CommentRatingsController < ApplicationController
  before_action :require_login
  before_action :set_rating, only: %i[ destroy ]

  # POST /articles/:article_id/comments/:comment_id/ratings
  def create
    comment = Comment.find(params[:comment_id])
    @rating = CommentRating.find_or_initialize_by(rater: current_user, comment: comment)

    value = params[:value].to_i

    if @rating.persisted? && @rating.value == value
      @rating.destroy
    else
      @rating.value = value
      @rating.save
    end

    respond_to do |format|
      format.html { redirect_to comment.article }
      format.json { head :ok }
    end
  end

  # DELETE /ratings/1
  def destroy
    comment = @rating.comment
    @rating.destroy if @rating.rater == current_user

    respond_to do |format|
      format.html { redirect_to comment.article, notice: "Rating removed." }
      format.json { head :no_content }
    end
  end

  private
    def set_rating
      @rating = CommentRating.find(params[:id])
    end
end