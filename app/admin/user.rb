ActiveAdmin.register User do


  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :password
    end
    f.actions
  end

  show do |user|
    attributes_table do
      #We want to keep the existing columns
      User.column_names.each do |column|
        row column
      end
      #This is where we add a new column
      row :login_as do
        link_to "#{user.email}", login_as_admin_user_path(user), :target => '_blank'
      end
    end
  end

   # Allows admins to login as a user 
  member_action :login_as, :method => :get do
    user = User.find(params[:id])
    sign_in(user, bypass: true)
    redirect_to sites_path 
  end


end
