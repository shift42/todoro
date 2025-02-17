require "rails_helper"

RSpec.describe Todoro::Task, type: :model do
  let(:project) { Project.create(name: "Project") }
  let(:task_list) { Todoro::TaskList.create(name: "Project Tasks", taskable: project) }
  let(:task) { Todoro::Task.create(title: "A task", task_list: task_list) }

  describe "associations" do
    it "has many task steps" do
      step1 = Todoro::TaskStep.create!(task: task, title: "Step 1")
      step2 = Todoro::TaskStep.create!(task: task, title: "Step 2")

      expect(task.task_steps).to include(step1, step2)
      expect(task.task_steps.count).to eq(2)
    end
  end

  it "is valid with a title, description, and status" do
    task = Todoro::Task.new(title: "Deploy to production", status: "pending", task_list: task_list)

    expect(task).to be_valid
  end

  it "is invalid without a title" do
    task = Todoro::Task.new(description: "Missing title", status: "pending", task_list: task_list)

    expect(task).not_to be_valid
    expect(task.errors[:title]).to include("can't be blank")
  end

  it "is invalid without a status" do
    task = Todoro::Task.new(title: "Missing status", description: "Testing", status: nil, task_list: task_list)

    expect(task).not_to be_valid
    expect(task.errors[:status]).to include("can't be blank")
  end

  it "can have multiple steps" do
    step1 = Todoro::TaskStep.create(task: task, title: "Step 1")
    step2 = Todoro::TaskStep.create(task: task, title: "Step 2")

    expect(task.task_steps.count).to eq(2)
    expect(task.task_steps).to include(step1, step2)
  end

  describe "#complete!" do
    it "updates the status and sets the completed_at to now" do
      datetime = Time.zone.local(2025, 2, 17, 10, 0, 0)

      travel_to datetime do
        task.complete!
      end

      expect(task.status).to eq('completed')
      expect(task.completed_at).to eq(datetime)
    end
  end
end
