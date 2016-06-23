class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  has_many :orders
  
  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
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

  validates_attachment_size :image, :less_than => 50.kilobytes
  validates_attachment_size :hkid_image, :less_than => 100.kilobytes
  validates_attachment_size :certificate_image, :less_than => 100.kilobytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
end
