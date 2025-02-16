require "rails_helper"

RSpec.describe "Todoro::TasksController", type: :request do
  include Todoro::Engine.routes.url_helpers

  let(:taskable) { create(:project) }
  let(:task_list) { create(:task_list, taskable: taskable) }
  let(:task) { create(:task, task_list: task_list, status: "pending") }

  describe "POST /:taskable_type/:taskable_id/task_lists/:task_list_id/tasks" do
    it "creates a new task" do
      expect {
        post project_task_list_tasks_path(taskable, task_list), params: {
          task: { title: "Refactor Code", description: "Improve structure", status: "pending" }
        }
      }.to change(Todoro::Task, :count).by(1)

      created_task = Todoro::Task.last
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(project_task_list_path(taskable, task_list))
    end
  end

  describe "PATCH /:taskable_type/:taskable_id/task_lists/:task_list_id/tasks/:id/complete" do
    it "marks task as completed" do
      patch complete_project_task_list_task_path(taskable, task_list, task)

      expect(response).to have_http_status(:redirect)
      expect(task.reload.status).to eq("completed")
    end
  end

  describe "DELETE /:taskable_type/:taskable_id/task_lists/:task_list_id/tasks/:id" do
    it "deletes a task" do
      task

      expect {
        delete project_task_list_task_path(taskable, task_list, task)
      }.to change(Todoro::Task, :count).by(-1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(project_task_list_path(taskable, task_list))
    end
  end
end
