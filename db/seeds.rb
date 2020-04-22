# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin   = User.create(role: :admin)
student1 = User.create(role: :student)
student2 = User.create(role: :student)
student3 = User.create(role: :student)
initial_task  = admin.initial_tasks.create(title: 'Task', body: 'Task body')
group = Group.create(students: [student2, student3])
personal_assigned_task = AssignedTask.create(admin: admin, student: student1, initial_task: initial_task)
group_assigned_task    = AssignedTask.create(admin: admin, group: group, initial_task: initial_task)

student1.send_answer(personal_assigned_task)
admin.reassign_task(personal_assigned_task)
student1.send_answer(personal_assigned_task)
admin.approve_task(personal_assigned_task)

student2.all_tasks
student2.send_answer(group_assigned_task)
admin.approve_task(group_assigned_task)
