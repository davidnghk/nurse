class Booking < ActiveRecord::Base
  include AASM
  
  belongs_to :user
  belongs_to :nurse, :class_name => 'User', :foreign_key => 'nurse_id'
  
  enum hospital: [:嘉諾撒醫院, :播道醫院, :香港港安醫院, :浸信會醫院, :養和醫院, :明德國際醫院, :寶血醫院, :聖保祿醫院, :聖德肋撒醫院, :荃灣港安醫院, :仁安醫院 ]
  enum status: [:Open, :Matched, :Completed, :Cancelled, :Rejected, :Pending, :Expired]
  enum payment: [:Paid, :Refunded, :NotPaid, :PaidOut]
  enum preferred_language: [:English, :中文, :Either]
  
  validates_presence_of :user_id, :order_datetime, :hours
  validates_datetime :order_datetime, :after => :today
  
  validates :contact_phone_no,  :presence => true, 
                        :numericality => true,
                        :length => { :minimum => 8, :maximum => 8 }
  
#  before_save :calculate_fee
#  before_update :calculate_fee
  
  aasm(:status) do
    state :Open, :initial => true
    state :Rejected, :Cancelled, :Matched, :Completed, :Expired

    event :engage do
      transitions :from => :Open, :to => :Matched
    end
    event :reject do
      transitions :from => [:Open, :Matched], :to => :Rejected
    end
    event :cancel do
      transitions :from => [:Open, :Matched], :to => :Cancelled
    end
    event :complete do
      transitions :from => :Matched, :to => :Completed
    end
    event :disengage do
      transitions :from => :Matched, :to => :Open
    end
    event :expire do
      transitions :from => :Open, :to => :Expired
    end
  end
  
  aasm(:payment) do
    state :Paid, :initial => true
    state :Refunded

    event :refund do
      transitions :from => :Paid, :to => :Refunded
    end
  end
  
  private
    def calculate_fee
      self.fee = (self.hours + 1) * 240
      self.cost = (self.hours + 1) * 200
    end 
  
    def book_in_the_past
      if self.order_datetime <= Date.today
        errors.add(:expiration_date, "can't be in the past")
      end
    end 
end
