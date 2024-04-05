class CartsController < ApplicationController
  before_action :find_product

  def create
    @item = build_cart_item
    if @item.save
      render notice: 'Item added to the Cart successfully'
    else
      render alert: 'Failed to add to cart'
    end

    respond_to(&:turbo_stream)
  end

  def show; end

  def destroy_item
    @cart_item = current_user_cart.cart_items.find(params[:item_id])
    if @cart_item.destroy
      flash.now[:notice] = 'Item removed from the Cart successfully'
    else
      flash.now[:alert] = 'Failed to add to cart'
    end
    respond_to(&:turbo_stream)
  end

  def update_quantity
    @cart_item = current_user_cart.cart_items.find(params[:item_id])
    quantity_change = params[:quantity].to_i

    if quantity_change >= 0
      @cart_item.update(quantity: quantity_change)
      flash.now[:notice] = 'Item Quantity has been updated'
    else
      flash.now[:alert] = 'Quantity cannot be negative.'
    end
    respond_to(&:turbo_stream)
  end


  private

  def build_cart_item
    item = current_user_cart.cart_items.find_or_initialize_by(product_id: @product.id)
    item.quantity += 1
    item
  end

  def find_product
    @product = Product.find_by(id: params[:product_id])
  end

  def cart_params
    params.require(:cart).permit(:product_id)
  end
end
