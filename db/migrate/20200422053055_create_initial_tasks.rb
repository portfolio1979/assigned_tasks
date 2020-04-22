class CreateInitialTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :initial_tasks do |t|
      t.belongs_to :user
      t.string     :title
      t.text       :body
      t.bigint     :assigned_tasks_count

      t.timestamps
    end
  end
end
