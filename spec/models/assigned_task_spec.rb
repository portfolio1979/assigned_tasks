require 'rails_helper'

RSpec.describe AssignedTask, type: :model do
  it { should belong_to(:admin).with_foreign_key('admin_id') }
  it { should belong_to(:student).with_foreign_key('student_id').optional }
  it { should belong_to(:group).optional }

  describe 'must belong to' do
    it 'student or group' do
      task = AssignedTask.create
      expect(task.errors.keys).to include :accessory
    end
  end

  describe 'assign status' do
    let!(:admin)   { create(:user, role: :admin) }
    let!(:student) { create(:user, role: :student) }
    let!(:initial_task) { create(:initial_task, user: admin) }
    let(:assigned_task) { create(:assigned_task, admin: admin, student: student, initial_task: initial_task) }

    context 'on create' do
      it 'it will be \'assigned\'' do
        assigned_task
        expect(assigned_task.status).to eq 'assigned'
      end
    end

    context 'on send answer' do
      it 'it will be \'consideration\'' do
        assigned_task
        student.send_answer(assigned_task)
        expect(assigned_task.status).to eq 'consideration'
      end
    end

    context 'on task reassign' do
      it 'it will be \'assigned\'' do
        assigned_task
        student.send_answer(assigned_task)
        admin.reassign_task(assigned_task)
        expect(assigned_task.status).to eq 'assigned'
      end
    end

    context 'on task approval' do
      it 'it will be \'approved\'' do
        assigned_task
        student.send_answer(assigned_task)
        admin.approve_task(assigned_task)
        expect(assigned_task.status).to eq 'approved'
      end
    end
  end
end
