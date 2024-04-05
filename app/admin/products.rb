ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  permit_params :name, :description, :stock, :price, :category_id, images: []

  form do |f|
    f.inputs do
      f.input :name
      f.input :description, require: false
      f.input :stock
      f.input :price
      f.input :images, as: :file, input_html: { multiple: true }
      f.input :category_id, as: :select, collection: Category.all
      f.semantic_errors *f.object.errors.attribute_names
    end
    f.actions do
      f.submit 'Create a new Product', as: :button
    end
  end

  controller do
    def create
      attrs = params[:product]

      @product = Product.create!(
        name: attrs[:name],
        description: attrs[:description] || '',
        stock: attrs[:stock],
        price: attrs[:price],
        category_id: attrs[:category_id]
      )
      @product.images.attach(params[:product][:images])

      if @product.save
        redirect_to '/admin/products'
      else
        render :new
      end
    end
  end

  show do
    if resource.images.attached?
      attributes_table(*resource.attributes.keys) do
        row "Photos" do |resource|
          resource.images.map { |photo| image_tag url_for photo }
        end
      end
    end
    # default_main_content
  end
end
