ActiveAdmin.register Product do
  config.sort_order = 'id_asc'
  config.per_page = 20

  # Permit parameters including category
  permit_params :name, :description, :price, :stock_quantity, :image, :category_id

  # Filters
  filter :name
  filter :price
  filter :stock_quantity
  filter :category
  filter :created_at
  filter :updated_at

  # Index Page
  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock_quantity
    column :category
    column :created_at
    column :updated_at
    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image), size: "50x50"
      end
    end
    actions
  end

  # Form
  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end

  # Show Page
  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock_quantity
      row :category
      row :created_at
      row :updated_at
      row :image do |product|
        if product.image.attached?
          helpers.image_tag url_for(product.image), size: "200x200"
        end
      end
    end
  end
end
