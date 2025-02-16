module Todoro
  class TaskListsController < ApplicationController
    before_action :set_task_list, only: %i[show edit update destroy]

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
        redirect_to [ @taskable, @task_list ], notice: "Task list created successfully."
      else
        render :new
      end
    end

    def edit; end

    def update
      if @task_list.update(task_list_params)
        redirect_to [ @taskable, @task_list ], notice: "Task list updated successfully."
      else
        render :edit
      end
    end

    def destroy
      taskable = @task_list.taskable
      @task_list.destroy

      redirect_to [ @taskable, :task_list ], notice: "Task list deleted."
    end

    private

    def set_task_list
      @task_list = @taskable.task_lists.find(params[:id])
    end

    def task_list_params
      params.require(:task_list).permit(:name)
    end
  end
end
