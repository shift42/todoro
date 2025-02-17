# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_02_17_191413) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "todoro_reminders", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.datetime "remind_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_todoro_reminders_on_task_id"
  end

  create_table "todoro_task_assignments", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.string "assignee_type", null: false
    t.bigint "assignee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_type", "assignee_id"], name: "index_todoro_task_assignments_on_assignee"
    t.index ["task_id"], name: "index_todoro_task_assignments_on_task_id"
  end

  create_table "todoro_task_lists", force: :cascade do |t|
    t.string "name", null: false
    t.string "taskable_type", null: false
    t.bigint "taskable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["taskable_type", "taskable_id"], name: "index_todoro_task_lists_on_taskable"
    t.index ["taskable_type", "taskable_id"], name: "index_todoro_task_lists_on_taskable_type_and_taskable_id"
  end

  create_table "todoro_task_steps", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.string "title"
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_todoro_task_steps_on_task_id"
  end

  create_table "todoro_tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "due_date"
    t.string "status", default: "pending", null: false
    t.bigint "task_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "priority", default: 1, null: false
    t.integer "recurrence_pattern"
    t.datetime "completed_at"
    t.index ["due_date"], name: "index_todoro_tasks_on_due_date"
    t.index ["status"], name: "index_todoro_tasks_on_status"
    t.index ["task_list_id"], name: "index_todoro_tasks_on_task_list_id"
    t.check_constraint "(recurrence_pattern = ANY (ARRAY[0, 1, 2, 3])) OR recurrence_pattern IS NULL", name: "recurrence_check"
    t.check_constraint "priority = ANY (ARRAY[0, 1, 2])", name: "priority_check"
    t.check_constraint "status::text = ANY (ARRAY['pending'::character varying, 'completed'::character varying]::text[])", name: "status_check"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "todoro_reminders", "todoro_tasks", column: "task_id"
  add_foreign_key "todoro_task_assignments", "todoro_tasks", column: "task_id"
  add_foreign_key "todoro_task_steps", "todoro_tasks", column: "task_id"
  add_foreign_key "todoro_tasks", "todoro_task_lists", column: "task_list_id"
end
