ActiveAdmin.register Category do
  config.sort_order = 'id_asc'
  permit_params :name

  # Index page
  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end

  # Filters
  filter :name
  filter :created_at

  # Form
  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  # Show page: list products in the category
  show do
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
    end

    panel "Products in this Category" do
      table_for category.products.order(:id) do
        column :id
        column :name
        column :price
        column :stock_quantity
        column :created_at
        column :updated_at
        column("Actions") { |product| link_to "View", admin_product_path(product) }
      end
    end
  end
end
