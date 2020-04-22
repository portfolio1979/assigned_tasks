require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:initial_tasks).dependent(:destroy) }
  it { should have_many(:was_assigned_tasks).dependent(:destroy) }
  it { should have_many(:personal_assigned_tasks).dependent(:destroy) }
  it { should have_many(:students_groups) }
  it { should have_many(:groups).through(:students_groups) }

  let!(:admin)   { create(:user, role: :admin) }
  let!(:student) { create(:user, role: :student) }
  let!(:group)   { create(:group) }
  let!(:initial_task)    { create(:initial_task, user: admin) }
  let(:personal_assigned_task) { create(:assigned_task, admin: admin, student: student, initial_task: initial_task) }
  let(:group_assigned_task)    { create(:assigned_task, admin: admin, group: group, initial_task: initial_task) }

  describe 'student all tasks' do
    it 'will show personal tasks with group tasks' do
      personal_assigned_task
      group_assigned_task

      expect(student.all_tasks).to include personal_assigned_task
      expect(student.all_tasks).to_not include group_assigned_task

      group.students << student

      student.reload
      expect(student.groups).to include group
      expect(student.all_tasks).to include personal_assigned_task
      expect(student.all_tasks).to include group_assigned_task
    end
  end

  describe 'admin can' do
    context 'assign task to' do
      context 'student' do
        before { personal_assigned_task }
        it 'admin can assign task' do
          expect(student.personal_assigned_tasks).to include personal_assigned_task
        end
        it 'student can send answer on task' do
          student.send_answer(personal_assigned_task)
          expect(personal_assigned_task.status).to eq 'consideration'
        end
        it 'admin can reassign task' do
          admin.reassign_task(personal_assigned_task)
          expect(personal_assigned_task.status).to eq 'assigned'
        end
        it 'admin can approve task' do
          admin.approve_task(personal_assigned_task)
          expect(personal_assigned_task.status).to eq 'approved'
        end
      end
      context 'group' do
        before { group_assigned_task }
        it 'admin can assign task' do
          group.students << student
          expect(group.assigned_tasks).to include group_assigned_task
        end
      end
    end
  end
end
