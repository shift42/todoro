class TaskableModelsConstraint
  def matches?(request)
    taskable_type = request.params[:taskable_type]&.classify
    Todoro.taskable_models.include?(taskable_type)
  end
end
