require "rails_helper"

RSpec.describe Project, type: :model do
  it "has many task lists" do
    project = create(:project)
    task_list = create(:task_list, taskable: project)

    expect(project.task_lists).to include(task_list)
  end

  it "can have multiple tasks through task lists" do
    project = create(:project)
    task_list = create(:task_list, taskable: project)
    task = create(:task, task_list: task_list)

    expect(project.tasks).to include(task)
  end
end
