class User < ActiveRecord::Base
#  include AASM
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  
  scope :customer, -> { where(role: :customer)}
  scope :partner, -> { where(role: :partner)}

  enum role: [:customer, :partner, :admin, :user, :vip]
  enum qualification: [:registered_nurse, :enrolled_nurse]
  enum status: [:Pending, :Approved, :Disapproved]
  enum bank: [:匯豐銀行, :恒生銀行, :渣打銀行, :中國銀行, :美國銀行, :中國建設銀行, :花旗銀行, :星展銀行 ]

  validates_presence_of :name
  validates_uniqueness_of :email
  
  validates :phone_no,  :presence => true, 
                        :numericality => true,
                        :length => { :minimum => 8, :maximum => 8 }
  
  validates :bank_account_no,  
                        :length => { :maximum => 15 }
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
  has_attached_file :certificate_image, styles: { large: "1200x900>", medium: "400x300>"}
  validates_attachment_content_type :certificate_image, content_type: /\Aimage\/.*\Z/
  
  has_attached_file :hkid_image, styles: { large: "1200x900>", medium: "400x300>" }
  validates_attachment_content_type :hkid_image, content_type: /\Aimage\/.*\Z/
  
#  validates_attachment_size :image, :less_than => 50.kilobytes
#  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']  
  
#  after_initialize :set_default_role, :if => :new_record?

#  aasm do
#    state :Approved, :initial => true
#    state :Pending, :Disapproved 
#
#    event :Approve do
#      transitions :from => :Pending, :to => :Approved
#    end
#
#    event :Disapprove do
#      transitions :from => [:Pending, :Approved], :to => :Disapproved 
#    end
#
#    event :Pend do
#      transitions :from => :Approved, :to => :pending
#    end
#    
#  end
    
#  def set_default_role
#    self.role ||= :customer
#  end

  def to_label
    "#{name}"
  end
end
