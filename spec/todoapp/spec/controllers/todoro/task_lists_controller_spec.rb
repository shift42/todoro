require "rails_helper"

RSpec.describe Todoro::TaskListsController, type: :request do
  include Todoro::Engine.routes.url_helpers

  let(:taskable) { create(:project) }
  let(:task_list) { create(:task_list, taskable: taskable) }

  describe "GET /:taskable_type/:taskable_id/task_lists" do
    it "returns success" do
      get project_task_lists_path(taskable)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Task Lists for Project: #{taskable.name}")
    end
  end

  describe "POST /:taskable_type/:taskable_id/task_lists" do
    it "creates a task list for the taskable" do
      expect {
        post project_task_lists_path(taskable), params: { task_list: { name: "New Task List" } }
      }.to change(Todoro::TaskList, :count).by(1)

      created_task_list = Todoro::TaskList.last

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(project_task_list_path(taskable, created_task_list))
    end
  end

  describe "DELETE /:taskable_type/:taskable_id/task_lists/:id" do
    it "deletes a task list and ensures correct routing inside the engine" do
      task_list

      expect {
        delete project_task_list_path(taskable, task_list)
      }.to change(Todoro::TaskList, :count).by(-1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(project_task_list_path(taskable))
    end
  end
end
