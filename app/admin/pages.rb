ActiveAdmin.register Page do
  permit_params :title, :content

  # Optional: custom form
  form do |f|
    f.inputs do
      f.input :title
      f.input :content
    end
    f.actions
  end
end
