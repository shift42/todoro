require "todoro/version"
require "todoro/engine"
require "todoro/taskable"
require "todoro/taskable_assignee"

module Todoro
  mattr_accessor :assignable_models
  self.assignable_models = []

  def self.taskable_models
    Rails.application.eager_load!

    ActiveRecord::Base.descendants.select do |model|
      model.included_modules.include?(Todoro::Taskable)
    end.map(&:name)
  end
end
