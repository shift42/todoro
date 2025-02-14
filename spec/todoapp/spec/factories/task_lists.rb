FactoryBot.define do
  factory :task_list, class: "Todoro::TaskList" do
    name { "Test Task List" }
    association :taskable, factory: :project
  end
end
