class ProductsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @product = Product.find_by(id: params[:id])
    @reviews = @product.reviews
    @query = @reviews.ransack(params[:query])
    @query.sorts = ['created_at asc'] if @query.sorts.empty?
    @pagy, @reviews = pagy(@query.result)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
    render :show, status: :ok
  end

  def index
    @query = Product.with_attached_images.ransack(params[:query])
    @query.sorts = ['created_at asc'] if @query.sorts.empty?
    @pagy, @products = pagy(@query.result)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
    render :index, status: :ok
  end
end
