ActiveAdmin.register Order do
  # Permit all attributes needed for create/update
  permit_params :status_int, :customer_id, :gst, :pst, :hst, :total

  # Filters
  filter :customer
  filter :gst
  filter :pst
  filter :hst
  filter :total
  filter :status_int, as: :select, collection: Order.status_ints.keys.map { |s| [s.humanize, s] }

  index do
    selectable_column
    id_column
    column :customer
    column :gst
    column :pst
    column :hst
    column :total
    column :status_int do |order|
      status_tag(order.status_int.humanize, class: order.status_int)
    end
    actions
  end

  show do
    attributes_table do
      row :customer
      row :gst
      row :pst
      row :hst
      row :total
      row :status_int do |order|
        status_tag(order.status_int.humanize, class: order.status_int)
      end
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :price
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :customer
      f.input :gst
      f.input :pst
      f.input :hst
      f.input :total
      f.input :status_int, as: :select, collection: Order.status_ints.keys
    end
    f.actions
  end
end
