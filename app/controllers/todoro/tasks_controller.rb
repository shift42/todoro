module Todoro
  class TasksController < ApplicationController
    before_action :set_task_list
    before_action :set_task, only: %i[edit update destroy complete]

    def new
      @task = @task_list.tasks.new
    end

    def create
      @task = @task_list.tasks.new(task_params)
      if @task.save
        redirect_to @task_list, notice: "Task created successfully."
      else
        render :new
      end
    end

    def edit; end

    def update
      if @task.update(task_params)
        redirect_to @task_list, notice: "Task updated successfully."
      else
        render :edit
      end
    end

    def destroy
      @task.destroy
      redirect_to @task_list, notice: "Task deleted."
    end

    def complete
      @task.update(status: "completed")
      redirect_to @task_list, notice: "Task marked as completed."
    end

    private

    def set_task_list
      @task_list = TaskList.find(params[:task_list_id])
    end

    def set_task
      @task = @task_list.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :expiry_date, :status)
    end
  end
end

