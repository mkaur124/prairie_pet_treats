ActiveAdmin.register Page do
   config.sort_order = 'id_asc'
  permit_params :title, :content, :slug

  form do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :text
      f.input :slug
    end
    f.actions
  end
end
