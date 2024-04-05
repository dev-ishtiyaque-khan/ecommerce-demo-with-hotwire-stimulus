require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'Associations' do
    it { is_expected.to have_one(:cart) }
  end
end
