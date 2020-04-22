require 'rails_helper'

RSpec.describe InitialTask, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:assigned_tasks).dependent(:destroy) }

  describe 'initial task' do
    let!(:admin) { create(:user, role: :admin) }
    let!(:student) { create(:user, role: :student) }
    it 'can\'t be created by student' do
      expect{student.initial_tasks.create}.to_not change(InitialTask, :count)
    end
    it 'can be created by admin' do
      expect{admin.initial_tasks.create}.to change(InitialTask, :count).by(1)
    end
  end
end
