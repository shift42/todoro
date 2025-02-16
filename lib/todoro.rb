require "todoro/version"
require "todoro/engine"
require "todoro/taskable"

module Todoro
  def self.taskable_models
    Rails.application.eager_load!

    ActiveRecord::Base.descendants.select do |model|
      model.included_modules.include?(Todoro::Taskable)
    end.map(&:name)
  end
end
