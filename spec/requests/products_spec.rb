require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe '#show' do
    let(:product) { create(:product) }
    let(:category) { product.category }

    it 'renders show page' do
      get '/products', params: { products: { id: product.id } }
      expect(response).to have_http_status(:success)
      # expect(response).to render_template(:show)
    end
  end

  describe '#index' do
    let(:category) { create_list(:category, 3) }
    let(:category_id) { category.second.id }

    it 'renders index page' do
      get '/products'
      expect(response).to have_http_status(:success)
      # expect(response).to render_template(:index)
    end

    context 'sorts product by category' do
      let(:products) { create_list(:product, 2, category_id: category_id) }

      it 'renders index page' do
        get '/products', params: {
          query: {
            category_id_in: ['1'],
          }
        }

        expect(products.select { |x| x[:category_id] == 2 }.count).to match(2)
      end
    end

    context 'sorts product by price range' do
      let(:products) do
        [
          create(:product, category_id: category_id, price: 4),
          create(:product, category_id: category_id, price: 3),
          create(:product, category_id: category_id, price: 10),
        ]
      end

      it 'renders index page' do
        get '/products', params: {
          query: {
            price_gteq: '3',
            price_lteq: '5',
          }
        }

        expect(products.select { |x| x[:price] >= 3 and x[:price] <= 5 }.count).to match(2)
      end
    end
  end
end
