class TasksController < ApplicationController

  before_action :require_user

  def index
    # if params[:include_future]
    #   @tasks = Task.where(status: "Open")
    # else
      @tasks = Task.where("due_date <= ?", Date.today).where(status: "Open").where(user_id: current_user.id).order(:created_at)
      @past_due_tasks = Task.where("due_date < ?", Date.today).where(status: "Open").where(user_id: current_user.id).order(:due_date)
      @today_tasks = Task.where("due_date = ?", Date.today).where(status: "Open").where(user_id: current_user.id).order(:created_at)
      @future_tasks = Task.where("due_date > ?", Date.today).where(status: "Open").where(user_id: current_user.id).order(:due_date)
      @completed_tasks = Task.where(status: "Done").where(user_id: current_user.id).order(:due_date)
    # end
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
