class TasksController < ApplicationController

  before_action :require_user

  def index
    @past_due_tasks  = current_user.tasks.open.past.sorted.to_a
    @today_tasks     = current_user.tasks.due_today.open.sorted.to_a
    @future_tasks    = current_user.tasks.future.open.sorted.to_a
    @completed_tasks = current_user.tasks.done.sorted.to_a
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.create(task_params.merge(user_id: current_user.id))
    if task.errors.present?
      flash[:errors] = task.errors.full_messages
    end  
    redirect_to tasks_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(task_params)
    redirect_to tasks_path
  end

  def mark_as_done
    @task = Task.find(params[:id])
    @task.update_attributes(status: "Done")
    redirect_to tasks_path
  end

  def mark_as_open
    @task = Task.find(params[:id])
    @task.update_attributes(status: "Open")
    redirect_to tasks_path
  end

  def show
    @task = Task.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:name, :due_date, :status)
  end

end
