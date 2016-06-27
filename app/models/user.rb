class User < ActiveRecord::Base
  include AASM
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  
  scope :customer, -> { where(role: :customer)}
  scope :partner, -> { where(role: :partner)}
  
  has_many :orders, :class_name => 'Order', :foreign_key => 'user_id' 
  has_many :services, :class_name => 'Order', :foreign_key => 'server_id'

  enum role: [:customer, :partner, :admin, :user, :vip]
  enum qualification: [:registered_nurse, :enrolled_nurse]
  enum status: [:Pending, :Approved, :Disapproved]

  validates_presence_of :name
  validates_uniqueness_of :email
  
#  validates_length_of :phone_no, :minimum => 10, :maximum => 10 
#  validates :phone_no, format: { with: /\d{8}/, message: "bad format" }
  
  has_attached_file :image, styles: { medium: "200x300>", thumb: "150x200>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
  has_attached_file :certificate_image, styles: { large: "900x900>", thumb: "100x100>" }
  validates_attachment_content_type :certificate_image, content_type: /\Aimage\/.*\Z/
  
  has_attached_file :hkid_image, styles: { medium: "300x200>", thumb: "150x100>" }
  validates_attachment_content_type :hkid_image, content_type: /\Aimage\/.*\Z/
  
#  validates_attachment_size :image, :less_than => 50.kilobytes
#  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']  
  
#  after_initialize :set_default_role, :if => :new_record?

  aasm do
    state :Approved, :initial => true
    state :Pending, :Disapproved 

    event :Approve do
      transitions :from => :Pending, :to => :Approved
    end

    event :Disapprove do
      transitions :from => [:Pending, :Approved], :to => :Disapproved 
    end

    event :Pend do
      transitions :from => :Approved, :to => :pending
    end
    
  end
    
#  def set_default_role
#    self.role ||= :customer
#  end

  def to_label
    "#{name}"
  end
end
