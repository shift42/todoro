require "rails_helper"

RSpec.describe Todoro::TaskAssignment, type: :model do
  let(:project) { Project.create!(name: "A project") }
  let(:task_list) { Todoro::TaskList.create!(taskable: project, name: "Test Task List") }
  let(:task) { Todoro::Task.create!(task_list:, title: "Test Task") }
  let(:user) { User.create!(name: "Despo") }
  let(:employee) { Employee.create!(name: "Despo") }

  it "allows assigning a task to any taskable_assignee" do
    task.assign_to(user)
    task.assign_to(employee)
    expect(task.users).to include(user)
    expect(task.employees).to include(employee)
  end

  it "prevents assigning a task to an unregistered model" do
    unregistered_model = Project.create(name: 'A project cannot be assigned')
    assignment = task.task_assignments.build(assignee: project)

    expect(assignment).not_to be_valid
    expect(assignment.errors[:assignee]).to include("Project is not a registered taskable model")
  end
end
