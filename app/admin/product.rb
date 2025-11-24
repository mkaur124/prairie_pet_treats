ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :image

  # Optional: Add filters
  filter :name
  filter :price
  filter :stock_quantity

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock_quantity
    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image), size: "50x50"
      end
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :image, as: :file
    end
    f.actions
  end
end
