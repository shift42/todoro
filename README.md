# Todoro

A lightweight Rails engine that lets any model manage task lists and tasks with a simple, flexible API.

![Totoro](totoro.png)

## Installation

Add to your Gemfile:

```ruby
gem "todoro"
```

And then execute:

```sh
$ bundle install
```

Or install it yourself as:

```sh
$ gem install todoro
```

## Usage

Generate the required migrations:

```sh
$ rails generate todoro:install
$ rails db:migrate
```

Include `acts_as_taskable` in the model(s) that can have tasks:

```ruby
class Project < ApplicationRecord
  acts_as_taskable
end
```

Now, a `Project` can have task lists and tasks:

```ruby
project = Project.create(name: "Website Redesign")
task_list = project.create_task_list("Development Tasks")
task = project.add_task_to_list(task_list, "Build homepage", "Implement UI components")

puts project.tasks # Lists all tasks in all its task lists
```

## Automatic Route Generation

Todoro automatically generates routes for any model that includes `acts_as_taskable`. For example, if `Project` includes `acts_as_taskable`, the following routes are created:

```sh
GET    /projects/:project_id/task_lists(.:format)
POST   /projects/:project_id/task_lists(.:format)
GET    /projects/:project_id/task_lists/:id(.:format)
PATCH  /projects/:project_id/task_lists/:id(.:format)
DELETE /projects/:project_id/task_lists/:id(.:format)
GET    /projects/:project_id/task_lists/:task_list_id/tasks(.:format)
POST   /projects/:project_id/task_lists/:task_list_id/tasks(.:format)
```

These routes are automatically configured, so no additional setup is needed.

## Mounting the Engine

To access Todoro's routes, mount the engine in your application's routes file:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount Todoro::Engine, at: "/"
  # Other routes...
end
```

Since Todoro dynamically registers routes for `acts_as_taskable` models, no further route configuration is required.

## License

The gem is available as open source under the terms of the [MIT License](MIT-LICENSE).
