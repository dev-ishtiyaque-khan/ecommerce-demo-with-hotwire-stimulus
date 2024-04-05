require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:content) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:commentable) }
  end
end
