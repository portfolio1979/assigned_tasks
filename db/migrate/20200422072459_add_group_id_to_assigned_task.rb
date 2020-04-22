class AddGroupIdToAssignedTask < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :assigned_tasks, :group
  end
end
