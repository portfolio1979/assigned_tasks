class Group < ApplicationRecord
  has_many :students_groups
  has_many :students, through: :students_groups, class_name: 'User'
  has_many :assigned_tasks
end
