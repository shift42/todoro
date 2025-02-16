module Todoro
  class ApplicationController < ::ApplicationController
    before_action :set_taskable
    before_action :validate_taskable!

    private

    def set_taskable
      taskable_type = params[:taskable_type]&.classify
      taskable_id_param = "#{params[:taskable_type]}_id"
      taskable_id = params[taskable_id_param]

      if taskable_type.present? && taskable_id.present? && Todoro.taskable_models.include?(taskable_type)
        @taskable = taskable_type.safe_constantize&.find_by(id: taskable_id)
      end

      render json: { error: "Taskable not found" }, status: :not_found unless @taskable
    end

    def validate_taskable!
      unless @taskable && Todoro.taskable_models.include?(@taskable.class.name)
        render json: { error: "Unauthorized taskable model" }, status: :forbidden
      end
    end
  end
end
