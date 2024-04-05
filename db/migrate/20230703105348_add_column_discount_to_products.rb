class AddColumnDiscountToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :discount, :float
  end
end
