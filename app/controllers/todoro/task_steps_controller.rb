module Todoro
  class TaskStepsController < ApplicationController
    before_action :set_task
    before_action :set_task_step, only: [ :complete, :destroy ]

    def create
      @task_step = @task.task_steps.build(task_step_params)

      if @task_step.save
        respond_to do |format|
          format.html { redirect_to [ @taskable, @task.task_list ], notice: "Subtask added." }
          format.turbo_stream
        end
      else
        render :new
      end
    end

    def complete
      @task_step.update(completed: true)
      respond_to do |format|
        format.html { redirect_to [ @taskable, @task.task_list ], notice: "Subtask marked as completed." }
        format.turbo_stream
      end
    end

    def destroy
      @task_step.delete
      respond_to do |format|
        format.html { redirect_to [ @taskable, @task.task_list ], notice: "Subtask marked as completed." }
        format.turbo_stream
      end
    end

    private

    def set_task
      @task = Todoro::Task.find(params[:task_id])
    end

    def set_task_step
      @task_step = @task.task_steps.find(params[:id])
    end

    def task_step_params
      params.require(:task_step).permit(:title, :complete)
    end
  end
end
