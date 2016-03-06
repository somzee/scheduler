class TasksController < ApplicationController

  def index
    @tasks = Task.where("due_date <= ?", Date.today).where(status: "Open")
  end

  def new
    @task = Task.new
  end

  def create
    Task.create(task_params)
    # Task.create(task_params.merge(status: "Open"))
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

  private

  def task_params
    params.require(:task).permit(:name, :due_date, :status)
  end

end