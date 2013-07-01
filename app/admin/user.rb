ActiveAdmin.register User do
  menu :parent => "Config"

  index do
    column :username
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :username

  form do |f|
    f.inputs "Admin Details" do
      f.input :username
    end
    f.actions
  end
end
