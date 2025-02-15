To enhance the **Todoro** gem's documentation, here's an updated version of the `README.md` file that includes instructions on mounting the engine and customizing the mount path:

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

## Mounting the Engine

To access Todoro's routes, mount the engine in your application's routes file:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount Todoro::Engine, at: '/todoro'
  # Other routes...
end
```

This makes Todoro's features accessible under the `/todoro` path (e.g., `http://yourdomain.com/todoro`).

### Customizing the Mount Path

You can mount Todoro at any path that fits your application's structure:

- To mount at the root:

  ```ruby
  Rails.application.routes.draw do
    mount Todoro::Engine, at: '/'
    # Other routes...
  end
  ```

  Now, Todoro's routes are available at the root URL (e.g., `http://yourdomain.com/`).


## License

The gem is available as open source under the terms of the [MIT License](MIT-LICENSE).
