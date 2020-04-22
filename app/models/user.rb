class User < ApplicationRecord
  has_many :initial_tasks, dependent: :destroy
  has_many :was_assigned_tasks, class_name: 'AssignedTask', dependent: :destroy, foreign_key: :admin_id
  has_many :personal_assigned_tasks, class_name: 'AssignedTask', dependent: :destroy, foreign_key: :student_id
  has_many :students_groups, foreign_key: :student_id
  has_many :groups, through: :students_groups

  enum role: %i[admin student]

  def assign_personal_task(student, initial_task)
    return unless admin? && (initial_task.is_a? InitialTask)

    AssignedTask.create(admin: self, student: student, initial_task: initial_task)
  end

  def assign_group_task(group, initial_task)
    return unless admin? && (initial_task.is_a? InitialTask)

    AssignedTask.create(admin: self, group: group, initial_task: initial_task)
  end

  def reassign_task(task)
    return unless admin? && (task.is_a? AssignedTask)

    task.assigned!
  end

  def approve_task(task)
    return unless admin? && (task.is_a? AssignedTask)

    task.approved!
  end

  def send_answer(task)
    return unless task.is_a? AssignedTask

    task.consideration!
  end

  def all_tasks
    return personal_assigned_tasks if groups.blank?

    groups.each { |g| self.personal_assigned_tasks += g.assigned_tasks }
    personal_assigned_tasks
  end
end
