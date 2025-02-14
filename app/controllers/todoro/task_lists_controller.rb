module Todoro
  class TaskListsController < ApplicationController
    before_action :set_task_list, only: %i[show edit update destroy]

    def index
      @task_lists = TaskList.all
    end

    def show; end

    def new
      @task_list = TaskList.new
    end

    def create
      @task_list = TaskList.new(task_list_params)
      if @task_list.save
        redirect_to @task_list, notice: "Task list created successfully."
      else
        render :new
      end
    end

    def edit; end

    def update
      if @task_list.update(task_list_params)
        redirect_to @task_list, notice: "Task list updated successfully."
      else
        render :edit
      end
    end

    def destroy
      @task_list.destroy
      redirect_to task_lists_path, notice: "Task list deleted."
    end

    private

    def set_task_list
      @task_list = TaskList.find(params[:id])
    end

    def task_list_params
      params.require(:task_list).permit(:name, :taskable_id, :taskable_type)
    end
  end
end

