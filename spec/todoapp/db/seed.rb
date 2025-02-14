project = Project.create!(name: "Test Project")

task_list = project.create_task_list("Development Tasks")

task_list.tasks.create!(title: "Fix Bugs", description: "Critical Issue", status: "pending")
task_list.tasks.create!(title: "Refactor Code", description: "Improve readability", status: "pending")

puts "✅ Seeded test data in todoapp!"
