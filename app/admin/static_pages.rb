ActiveAdmin.register StaticPage do
  config.sort_order = 'id_asc'
  permit_params :title, :content, :slug

  form do |f|
    f.inputs do
      f.input :title
      f.input :slug
      f.input :content, as: :quill_editor
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :slug
      row :content
      row :created_at
      row :updated_at
    end
  end
end
