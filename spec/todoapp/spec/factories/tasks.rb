FactoryBot.define do
  factory :task, class: "Todoro::Task" do
    title { "Test Task" }
    description { "This is a test task." }
    status { "pending" }
    association :task_list
  end
end
