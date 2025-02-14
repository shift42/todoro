require "rails_helper"

RSpec.describe Todoro::Task, type: :model do
  let(:project) { Project.create(name: "Project") }
  let(:task_list) { Todoro::TaskList.create(name: "Project Tasks", taskable: project) }

  it "is valid with a title, description, and status" do
    task = Todoro::Task.new(title: "Deploy to production", description: "Ensure zero downtime", status: "pending", task_list: task_list)

    expect(task).to be_valid
  end

  it "is invalid without a title" do
    task = Todoro::Task.new(description: "Missing title", status: "pending", task_list: task_list)

    expect(task).not_to be_valid
    expect(task.errors[:title]).to include("can't be blank")
  end

  it "is invalid without a description" do
    task = Todoro::Task.new(title: "Missing description", status: "pending", task_list: task_list)

    expect(task).not_to be_valid
    expect(task.errors[:description]).to include("can't be blank")
  end

  it "is invalid without a status" do
    task = Todoro::Task.new(title: "Missing status", description: "Testing", status: nil, task_list: task_list)

    expect(task).not_to be_valid
    expect(task.errors[:status]).to include("can't be blank")
  end
end
