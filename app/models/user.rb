class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  
  scope :manager, -> { where(role: :manager)}
  scope :admin, -> { where(role: :admin)}
  scope :repariman, -> { where(role: :repairman)}

  enum role: [:manager, :admin, :repairman, :customer]
  enum qualification: [:registered_nurse, :enrolled_nurse]
  enum status: [:Pending, :Approved, :Disapproved]

  validates_presence_of :name
  validates_uniqueness_of :email
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>" }
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/pdf']  
  
  def to_label
    "#{name}"
  end
end
