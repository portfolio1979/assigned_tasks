class InitialTask < ApplicationRecord
  belongs_to :user
  has_many :assigned_tasks, counter_cache: true, dependent: :destroy

  validate :user_admin?

  private

  def user_admin?
    errors.add(:ability, 'not enough rights') unless user.try(:admin?)
  end
end
