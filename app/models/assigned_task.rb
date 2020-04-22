class AssignedTask < ApplicationRecord
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'
  belongs_to :student, class_name: 'User', foreign_key: 'student_id', optional: true
  belongs_to :initial_task
  belongs_to :group, optional: true

  enum status: %i[assigned consideration approved]

  before_create :assign_status

  validate :group_or_student?

  private

  def assign_status
    self.status = 'assigned'
  end

  def group_or_student?
    errors.add(:accessory, 'need to be some one') if student_id.blank? && group_id.blank?
  end
end
