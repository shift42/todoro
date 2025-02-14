require "rails_helper"

RSpec.describe Todoro::TaskListsController, type: :controller do
  routes { Todoro::Engine.routes }

  let(:taskable) { Project.create(name: "Project") }
  let(:task_list) { Todoro::TaskList.create(name: "Chores", taskable: taskable) }

  describe "GET #index" do
    it "returns success" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    it "creates a task list" do
      expect {
        post :create, params: { task_list: { name: "Sprint Planning", taskable_id: taskable.id, taskable_type: taskable.class.to_s } }
      }.to change(Todoro::TaskList, :count).by(1)
    end
  end
end
