class CreateAssignedTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :assigned_tasks do |t|
      t.belongs_to :admin
      t.belongs_to :student
      t.belongs_to :initial_task
      t.integer    :status
      t.text       :body

      t.timestamps
    end
  end
end
