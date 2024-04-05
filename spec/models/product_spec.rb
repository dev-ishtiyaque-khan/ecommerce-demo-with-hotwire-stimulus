require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_numericality_of(:price) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:reviews) }
    it { is_expected.to belong_to(:category) }
  end
end
