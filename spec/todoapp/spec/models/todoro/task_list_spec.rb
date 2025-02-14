require "rails_helper"

RSpec.describe Todoro::TaskList, type: :model do
  let(:taskable) { Project.create(name: "Project") } # Generic taskable entity

  it "is valid with a name and taskable entity" do
    task_list = Todoro::TaskList.new(name: "Project Tasks", taskable: taskable)

    expect(task_list).to be_valid
  end

  it "is invalid without a name" do
    task_list = Todoro::TaskList.new(taskable: taskable)

    expect(task_list).not_to be_valid
    expect(task_list.errors[:name]).to include("can't be blank")
  end
end
