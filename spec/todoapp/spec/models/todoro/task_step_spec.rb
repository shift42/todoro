require "rails_helper"

RSpec.describe Todoro::TaskStep, type: :model do
  let(:project) { Project.create(name: "Project") }
  let(:task_list) { Todoro::TaskList.create(name: "Project Tasks", taskable: project) }
  let(:task) { Todoro::Task.create(title: "A task", task_list: task_list) }

  describe "associations" do
    it "belongs to a task" do
      step = Todoro::TaskStep.create!(task: task, title: "Step 1")
      expect(step.task).to eq(task)
    end
  end

  describe "validations" do
    it "is invalid without a title" do
      step = Todoro::TaskStep.new(task: task, title: nil)
      expect(step.valid?).to be false
      expect(step.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a task" do
      step = Todoro::TaskStep.new(task: nil, title: "Step 1")
      expect(step.valid?).to be false
      expect(step.errors[:task]).to include("must exist")
    end
  end

  describe "creation" do
    it "creates a valid task step" do
      step = Todoro::TaskStep.create(task: task, title: "Step 1")
      expect(step).to be_valid
    end
  end

  describe "completion status" do
    it "defaults to not completed" do
      step = Todoro::TaskStep.create(task: task, title: "Step 1")
      expect(step.completed).to be false
    end

    it "can be marked as completed" do
      step = Todoro::TaskStep.create(task: task, title: "Step 1", completed: true)
      expect(step.completed).to be true
    end
  end
end
