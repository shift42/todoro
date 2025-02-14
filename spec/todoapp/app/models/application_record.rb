class ApplicationRecord < ActiveRecord::Base
  include Todoro::Taskable

  primary_abstract_class
end
