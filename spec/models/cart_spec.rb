require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:items) }
  end
end
