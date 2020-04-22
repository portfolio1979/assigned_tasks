require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_many(:assigned_tasks) }
  it { should have_many(:students_groups) }
  it { should have_many(:students).through(:students_groups) }
end
