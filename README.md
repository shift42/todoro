# Todoro

A lightweight Rails engine that enables any model to manage task lists and tasks with a simple, flexible API.

![Totoro](totoro.png)

## Installation

Add `todoro` to your Gemfile:

```ruby
gem 'todoro'
```

Then execute:

```sh
$ bundle install
```

Or install it manually:

```sh
$ gem install todoro
```

## Usage

### Setup

Generate the required migrations:

```sh
$ rails generate todoro:install
$ rails db:migrate
```

### Making Models Taskable

Include `acts_as_taskable` in any model that should manage tasks:

```ruby
class Project < ApplicationRecord
  acts_as_taskable
end
```

This allows a `Project` to have task lists and tasks:

```ruby
project = Project.create(name: 'Website Redesign')
task_list = project.create_task_list('Development Tasks')
task = project.add_task_to_list(task_list, 'Build homepage', 'Implement UI components')

puts project.tasks # Lists all tasks across its task lists
```

### Assigning Tasks to Entities

To assign tasks to various entities (e.g., `User`, `Role`), ensure these models are assignable.

#### 1. Declare Assignable Models

In each model that should be assignable, simply call `taskable_assignee`:

```ruby
class User < ApplicationRecord
  taskable_assignee
end

class Role < ApplicationRecord
  taskable_assignee
end
```

#### 2. Assign Tasks

With models configured, assign tasks as follows:

```ruby
user = User.create(name: 'Jane Doe')
role = Role.create(name: 'Developer')

# Assign task to assignable models
task.assign_to(user)
task.assign_to(role)

# Retrieve specific assignees
task.employees # => [#<User id: 1, name: "Jane Doe">]
task.roles     # => [#<Role id: 1, name: "Developer">]
```

### Managing Task Steps

Tasks can be broken down into multiple steps, allowing for a structured workflow.

```ruby
# Add task steps
task.task_steps.create(title: 'Design UI mockups')
task.task_steps.create(title: 'Write backend API')

```

## Automatic Route Generation

Todoro automatically generates routes for any model that includes `acts_as_taskable`. For example, if `Project` includes `acts_as_taskable`, this is part of the generated routes:

```
/projects/:project_id/task_lists
/projects/:project_id/task_lists/:id
/projects/:project_id/task_lists/:id/tasks
/projects/:project_id/task_lists/:id/tasks/:id
/projects/:project_id/task_lists/:task_list_id/tasks/:id/complete
/projects/:project_id/task_lists/:task_list_id/tasks/:task_id/step
/projects/:project_id/task_lists/:task_list_id/tasks/:task_id/step/:id/complete
```

These routes allow for managing task lists and tasks within the context of the `Project` model.

## Mounting the Engine

To access Todoro's routes, mount the engine in your application's routes file:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount Todoro::Engine, at: '/'
  # Other routes...
end
```

Since Todoro dynamically registers routes for `acts_as_taskable` models, no further route configuration is required.

## License

The gem is available as open source under the terms of the [MIT License](MIT-LICENSE).
