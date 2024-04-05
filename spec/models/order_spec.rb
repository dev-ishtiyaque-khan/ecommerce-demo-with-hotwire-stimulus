require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:items) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
  end
end
