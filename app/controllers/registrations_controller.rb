class RegistrationsController < Devise::RegistrationsController
  force_ssl

  def edit
    @business = current_user.locations[0]
    super
  end
  
  def update
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path, :notice => "Your profile has been updated"
    else
      render "edit"
    end
  end
end