class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :set_task, only: [:create, :update, :destroy]

  def create
    @comment = Comment.new(comment_params.merge({task_id: @task.id, user_id: @current_user.id}))

    if @comment.save
      redirect_to @task, notice: 'Comment was successfully created.' 
    else
      redirect_to @task, notice: 'Comment was not created.' 
    end
  end

  def update
    if @current_user == @comment.user && @comment.update(comment_params)
      redirect_to @task, notice: 'Comment was successfully updated.' 
    else
      redirect_to @task, notice: 'Cannot update another user\'s comment.'
    end
  end

  def destroy
    if @current_user == @comment.user
      @comment.destroy
      redirect_to @task, notice: 'Comment was successfully destroyed.' 
    else
      redirect_to @task, notice: 'Cannot delete another user\'s comment.'
    end
  end

private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_task
    @task = Task.find(params[:task_id]) if params[:task_id]
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
