require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReviewsHelper.

RSpec.describe ReviewsHelper, type: :helper do
  describe '#review_star' do
    subject { helper.review_star(star_index, rating) }
    let(:default_class) { 'w-4 h-4 mr-1' }
    let(:gray) { 'text-gray-300' }
    let(:yellow) { 'text-yellow-300' }

    context 'when star_index is greater than user rating' do
      let(:star_index) { 4 }
      let(:rating) { 2 }

      it 'returns a gray star' do
        expect(subject).to match(gray)
      end
    end

    context 'when star_index is less than user rating' do
      let(:star_index) { 3 }
      let(:rating) { 5 }

      it 'returns a gray star' do
        expect(subject).to match(yellow)
      end
    end

    context 'when star_index is equal to user rating' do
      let(:star_index) { 5 }
      let(:rating) { 5 }

      it 'returns a gray star' do
        expect(subject).to match(yellow)
      end
    end

    it 'includes default class' do
      expect(subject).to match(default_class)
    end
  end

  describe '#sort_option_list' do
    subject { helper.sort_option_list }
    let(:rating_low_to_high) { ['Rating low to high', 'rating asc'] }
    let(:rating_high_to_low) { ['Rating high to low', 'rating desc'] }
    let(:latest_review) { ['Latest reviews', 'created_at desc'] }

    it 'returns Array' do
      is_expected.to be_a_kind_of(Array)
    end

    it 'lists available options' do
      expect(subject.flatten).to include('Default')
      expect(subject.flatten).to include('')

      expect(subject.flatten).to include(rating_low_to_high[0])
      expect(subject.flatten).to include(rating_low_to_high[1])

      expect(subject.flatten).to include(rating_high_to_low[0])
      expect(subject.flatten).to include(rating_high_to_low[1])

      expect(subject.flatten).to include(latest_review[0])
      expect(subject.flatten).to include(latest_review[1])
    end
  end
end
