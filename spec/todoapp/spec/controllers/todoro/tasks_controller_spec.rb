require "rails_helper"

RSpec.describe Todoro::TasksController, type: :controller do
  routes { Todoro::Engine.routes }

  let(:taskable) { Project.create(name: "Project") }
  let(:task_list) { Todoro::TaskList.create(name: "Development Tasks", taskable: taskable) }
  let(:task) { Todoro::Task.create(title: "Fix Bugs", description: "Critical issue", status: "pending", task_list: task_list) }

  describe "POST #create" do
    it "creates a new task" do
      expect {
        post :create, params: { task_list_id: task_list.id, task: { title: "Refactor Code", description: "Improve structure", status: "pending" } }
      }.to change(Todoro::Task, :count).by(1)
    end
  end

  describe "PATCH #complete" do
    it "marks task as completed" do
      patch :complete, params: { task_list_id: task_list.id, id: task.id }
      expect(task.reload.status).to eq("completed")
    end
  end
end
