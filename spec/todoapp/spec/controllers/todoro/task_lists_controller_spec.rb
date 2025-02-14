require "rails_helper"

RSpec.describe Todoro::TaskListsController, type: :controller do
  routes { Todoro::Engine.routes }

  let(:project) { create(:project) }
  let(:task_list) { create(:task_list, taskable: project) }

  describe "GET #index" do
    it "returns success" do
      get :index, params: { taskable: "Project", taskable_id: project.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    it "creates a task list for a project" do
      expect {
        post :create, params: { taskable: "Project", taskable_id: project.id, task_list: { name: "New Task List" } }
      }.to change(Todoro::TaskList, :count).by(1)
    end
  end
end

