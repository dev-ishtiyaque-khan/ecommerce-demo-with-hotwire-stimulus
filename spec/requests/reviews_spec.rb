require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:review) { create(:review, product_id: product.id, user_id: user.id) }

  describe '#create' do
    context 'when user is signed in' do
      before { login_as user, scope: :user }

      it 'redirects to product show page' do
        post '/products/1/reviews', params: { review: { product_id: product.id } }

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(product_path(review.product_id))
      end
      after { logout :user }
    end

    context 'when user is not signed in' do
      it 'redirects to login page' do
        post '/products/:product_id/reviews', params: { review: { product_id: review.product_id } }

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#index' do
    it 'renders index page' do
      get '/products/:product_id/reviews', params: { review: { product_id: product.id } }

      expect(response).to have_http_status(:success)
    end
  end
end
