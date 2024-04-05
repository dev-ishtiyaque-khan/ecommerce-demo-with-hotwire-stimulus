ActiveAdmin.register Category do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  permit_params :name

  form do |f|
    f.inputs do
      f.input :name
      f.semantic_errors *f.object.errors.attribute_names
    end
    f.actions do
      f.submit 'Create a new Product Category', as: :button
    end
  end

  controller do
    def create
      attrs = params[:category]

      name = attrs[:name]

      @category = Category.new(
        name: name
      )

      if @category.save
        redirect_to '/admin/categories'
      else
        render :new
      end
    end
  end
end
