require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_one(:comment) }
  end
end
