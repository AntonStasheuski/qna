require 'rails_helper'

RSpec.describe Reward, type: :model do
  context 'associations' do
    it { should belong_to(:question) }

    it { expect(build(:reward).file).to be_instance_of(ActiveStorage::Attached::One) }
  end

  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:file) }
  end
end
