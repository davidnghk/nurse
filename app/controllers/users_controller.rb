class UsersController < ApplicationController
#  before_action :authenticate_user!
#  after_action :verify_authorized
  
  def index
    @users = User.all
#    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    @user.update_attribute(:image, params[:user][:image])  
    @user.update_attribute(:hkid_image, params[:user][:hkid_image])  
    @user.update_attribute(:certificate_image, params[:user][:certificate_image])   
#    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end
  
end
