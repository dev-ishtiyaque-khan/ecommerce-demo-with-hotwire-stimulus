require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:products) }
  end
end
