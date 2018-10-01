class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.includes(:comments)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params.merge({user_id: @current_user.id}))

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.' 
    else
      render :new 
    end
  end

  def update
    if @current_user == @task.user && @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.' 
    else
      render :edit
    end
  end

  def destroy
    if @current_user == @task.user
      @task.destroy 
      redirect_to tasks_url, notice: 'Task was successfully destroyed.' 
    else
      redirect_to tasks_url, notice: 'You cannot destroy another user\'s task'
    end
  end

private
  def set_task
    @task = Task.includes(:comments => [:user]).find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :is_complete)
  end
end
