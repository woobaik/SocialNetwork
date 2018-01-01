class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership!, only: [:destroy]

  def create
    new_comment = Comment.new(content: params[:content],
                              post_id: params[:post_id],
                              user_id: current_user.id)

    new_comment.save
    redirect_back(fallback_location: root_path)

  end

  def destroy
    @comment.destroy
    redirect_back(fallback_location: root_url)

  end

  private
    def check_ownership!
      @comment = Comment.find_by(id: params[:id])
      redirect_to root_path if @comment.user.id != current_user.id
    end
end
