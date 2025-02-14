require "rails_helper"

RSpec.describe Todoro::TasksController, type: :controller do
  routes { Todoro::Engine.routes }

  let(:project) { create(:project) }
  let(:task_list) { create(:task_list, taskable: project) }
  let(:task) { create(:task, task_list: task_list) }

  describe "POST #create" do
    it "creates a new task" do
      expect {
        post :create, params: { taskable: "Project", taskable_id: project.id, task_list_id: task_list.id, task: { title: "Refactor Code", description: "Improve structure", status: "pending" } }
      }.to change(Todoro::Task, :count).by(1)
    end
  end

  describe "PATCH #complete" do
    it "marks task as completed" do
      patch :complete, params: { taskable: "Project", taskable_id: project.id, task_list_id: task_list.id, id: task.id }
      expect(task.reload.status).to eq("completed")
    end
  end
end

