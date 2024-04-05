require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:itemable) }
    it { is_expected.to belong_to(:product) }
  end
end
