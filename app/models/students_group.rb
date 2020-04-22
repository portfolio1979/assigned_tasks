class StudentsGroup < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :group
end
