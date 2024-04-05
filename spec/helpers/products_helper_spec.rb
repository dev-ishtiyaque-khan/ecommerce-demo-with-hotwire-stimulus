require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ProductsHelper. For example:
#

RSpec.describe ProductsHelper, type: :helper do
  describe '#category_selected?' do
    subject { helper.category_selected?(query, category_id) }
    let(:query) { { category_id_in: %w[1 2] } }
    let(:category_id) { 1 }

    context 'when given category is selected' do
      it 'returns true' do
        is_expected.to be_truthy
      end
    end

    context 'when given category is selected' do
      let(:category_id) { 3 }
      it 'returns false' do
        is_expected.to be_falsy
      end
    end
  end

  describe '#sort_option_list' do
    subject { helper.sort_option_list }
    let(:price_low_to_high) { ['Price low to high', 'price asc'] }
    let(:price_high_to_low) { ['Price high to low', 'price desc'] }
    let(:latest_product) { ['Latest products', 'created_at desc'] }

    it 'returns Array' do
      is_expected.to be_a_kind_of(Array)
    end

    it 'lists available options' do
      expect(subject.flatten).to include('Default')
      expect(subject.flatten).to include('')

      expect(subject.flatten).to include(price_low_to_high[0])
      expect(subject.flatten).to include(price_low_to_high[1])

      expect(subject.flatten).to include(price_high_to_low[0])
      expect(subject.flatten).to include(price_high_to_low[1])

      expect(subject.flatten).to include(latest_product[0])
      expect(subject.flatten).to include(latest_product[1])
    end
  end
end
