class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :find_product, only: %i[new create index destroy]

  def new
    @review = @product.reviews.build
  end

  def create
    @review = @product.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      respond_to do |format|
        format.html { redirect_to product_path(@product.id) }
        format.turbo_stream { flash.now[:notice] = 'Added new review.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def find_product
    @product = Product.find_by(id: params[:product_id])
  end

  def review_params
    params.require(:review).permit(:rating, :title, :comment, :product_id)
  end
end
