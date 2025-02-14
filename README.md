# Todoro
A lightweight Rails engine that lets any model manage task lists and tasks with a simple, flexible API.

![Totoro](totoro.png)

## Usage

Include Taskable in the model(s) that can have tasks

```ruby
class Project < ApplicationRecord
  acts_as_taskable
end
```

Now, a Project can have task lists and tasks!

```bash
project = Project.create(name: "Website Redesign")
task_list = project.create_task_list("Development Tasks")
task = project.add_task_to_list(task_list, "Build homepage", "Implement UI components")

puts project.tasks # Lists all tasks in all its task lists
```

## Installation

Add to your Gemfile:

```ruby
gem "todoro"
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install todoro
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
