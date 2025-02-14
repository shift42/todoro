module Todoro
  class TaskListsController < ApplicationController
    before_action :set_task_list, only: %i[show edit update destroy]
    before_action :set_taskable, only: %i[index new create]

    def index
      @task_lists = @taskable.task_lists
    end

    def show; end

    def new
      @task_list = @taskable.task_lists.new
    end

    def create
      @task_list = @taskable.task_lists.new(task_list_params)
      if @task_list.save
        redirect_to taskable_task_lists_path(taskable: @taskable), notice: "Task list created successfully."
      else
        render :new
      end
    end

    def edit; end

    def update
      if @task_list.update(task_list_params)
        redirect_to taskable_task_lists_path(taskable: @task_list.taskable), notice: "Task list updated successfully."
      else
        render :edit
      end
    end

    def destroy
      taskable = @task_list.taskable
      @task_list.destroy
      redirect_to taskable_task_lists_path(taskable: taskable), notice: "Task list deleted."
    end

    private

    def set_task_list
      @task_list = TaskList.find(params[:id])
    end

    def set_taskable
      @taskable = find_taskable
    end

    def find_taskable
      return unless params[:taskable] && params[:taskable_id]

      params[:taskable].constantize.find(params[:taskable_id])
    end

    def task_list_params
      params.require(:task_list).permit(:name)
    end
  end
end

