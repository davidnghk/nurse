class Booking < ActiveRecord::Base
  include AASM
  
  belongs_to :user
  belongs_to :nurse, :class_name => 'User', :foreign_key => 'nurse_id'
  
  enum hospital: { 嘉諾撒醫院: 1, 播道醫院: 2, 香港港安醫院: 3, 浸信會醫院: 4, 養和醫院: 5, 明德國際醫院: 6, 
    寶血醫院: 7, 聖保祿醫院: 8, 聖德肋撒醫院: 9, 荃灣港安醫院: 10, 仁安醫院: 11 }
  enum status: [:Open, :Matched, :Completed, :Cancelled, :Rejected, :Pending, :Expired]
  enum payment: [:Paid, :Refunded, :NotPaid, :PaidOut]
  enum preferred_language: [:English, :中文, :Either]
  
  validates_presence_of :user_id, :order_datetime, :hours
  validate :future_order 
  
  validates :contact_phone_no,  :presence => true, 
                        :numericality => true,
                        :length => { :minimum => 8, :maximum => 8 }
  
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

  def self.i18n_hospitals(hash = {})
    hospitals.keys.each { |key| hash[I18n.t("hospitals.#{key}")] = key }
    hash
  end
  
  def future_orders
    if order_datetime < Date.today+1.days
      errors.add(:order_datetime, "Only future date is allowed")
    end
  end 
end
