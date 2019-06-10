class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.recipe_id = params[:recipe_id]

      if @comment.save
        redirect_to recipe_path(@comment.recipe), notice: 'Комментарий опубликован!'  
      end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @comment.recipe, notice: 'Комментарий удален!' }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :recipe_id)
  end
end