class Booking < ActiveRecord::Base
  include AASM
  
  #before_save :calculate_refund
  
  belongs_to :user
  belongs_to :nurse, :class_name => 'User', :foreign_key => 'nurse_id'
  has_many :charges, :dependent => :destroy
  accepts_nested_attributes_for :charges, :allow_destroy => :true
  
  enum hospital: { 嘉諾撒醫院: 1, 播道醫院: 2, 香港港安醫院: 3, 浸信會醫院: 4, 養和醫院: 5, 明德國際醫院: 6, 
    寶血醫院: 7, 聖保祿醫院: 8, 聖德肋撒醫院: 9, 荃灣港安醫院: 10, 仁安醫院: 11 }
  enum status: [:Open, :Matched, :Completed, :Cancelled, :Rejected, :Pending, :Expired, :Confirmed]
  enum payment: [:Paid, :Refunded, :NotPaid, :PaidOut]
  enum preferred_language: [:English, :中文, :Either]
  
  validates_presence_of :user_id, :order_datetime, :hours
#  validates :order_datetime, in_future: true 
  validate :future_order
  validates_numericality_of :hours, integer_only: true, gt: 0
  validates_numericality_of :fee, integer_only: true, within: 500..5000
  validates_numericality_of :cost, integer_only: true, within: 500..5000 
  validates :contact_phone_no,  :presence => true, 
                        :numericality => true,
                        :length => { :minimum => 8, :maximum => 8 }
  
  before_update :calculate_fee
  
  aasm(:status) do
    state :Open, :initial => true
    state :Rejected, :Cancelled, :Matched, :Completed, :Expired, :Confirmed

    event :engage do
      transitions :from => :Open, :to => :Matched
    end
    event :reject do
      transitions :from => [:Open, :Matched], :to => :Rejected
    end
    event :cancel do
      transitions :from => [:Open, :Matched, :Confirmed], :to => :Cancelled
    end
    event :confirm do
      transitions :from => :Matched, :to => :Confirmed
    end
    event :disengage do
      transitions :from => :Matched, :to => :Open
    end
    event :expire do
      transitions :from => [:Open, :Matched], :to => :Expired
    end
    event :complete do
      transitions :from => :Confirmed, :to => :Completed
    end
  end
  
  aasm(:payment) do
    state :NotPaid, :initial => true
    state :Refunded, :NotPaid, :Paid

    event :refund do
      transitions :from => :Paid, :to => :Refunded
    end
    event :pay do
      transitions :from => :NotPaid, :to => :Paid
    end
  end

  
  public
  
  def calculate_fee
    if self.hours == 4
      self.fee  = 999
      self.cost = 800
    elsif self.hours == 8
      self.fee  = 1899
      self.cost = 1500
    else
      self.fee  = 2799
      self.cost = 2200
    end
  end
  
    
  private
  
  def calculate_refund
    self.cancellation_datetime = Time.now
    if self.cancellation_datetime + 24.hours < self.order_datetime
      self.refund_amount = self.fee
    elsif self.cancellation_datetime + 4.hours < self.order_datetime
      self.refund_amount = 300
    else
      self.refund_amount = 500
    end
  end
  
  def self.i18n_hospitals(hash = {})
    hospitals.keys.each { |key| hash[I18n.t("hospitals.#{key}")] = key }
    hash
  end
  
  def future_order
    if order_datetime < Time.now
      errors.add(:order_datetime, "Only future date is allowed")
    end
  end 
end
