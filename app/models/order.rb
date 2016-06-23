class Order < ActiveRecord::Base
  include AASM
  
#  attr_accessor :stripe_card_token
#  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year
  
  validates_presence_of :user_id, :booking_date, :booking_time, :stripe_card_token
#  validates_presence_of :location, :duration, :server_grade
#  validates_presence_of :contact_person, :contact_phone_no 
#  validates_length_of :contact_phone_no, :minimum => 8, :maximum => 8 
  
  belongs_to :user
  belongs_to :server, :class_name => 'User', :foreign_key => 'server_id'

  has_one :payment
  accepts_nested_attributes_for :payment
  
  enum hospital: [:嘉諾撒醫院, :播道醫院, :香港港安醫院, :浸信會醫院, :養和醫院, :明德國際醫院, :寶血醫院, :聖保祿醫院, :聖德肋撒醫院, :荃灣港安醫院, :仁安醫院 ]
  enum server_grade: [:註冊護士, :登記護士]
    
  before_save :calculate_fee
  before_update :calculate_fee
  
  aasm do
    state :open, :initial => true
    state :pending, :rejected, :cancelled, :confirmed, :completed

    event :pay do
      transitions :from => :pending, :to => :open
    end
    event :confirm do
      transitions :from => :open, :to => :confirmed
    end
    event :reject do
      transitions :from => [:pending, :open, :confirmed], :to => :rejected
    end
    event :cancel do
      transitions :from => [:pending, :open, :confirmed], :to => :cancelled
    end
    event :complete do
      transitions :from => :confirmed, :to => :completed
    end
    event :revoke do
      transitions :from => :confirmed, :to => :open
    end
  end
  
   before_save :calculate_fee
  before_update :calculate_fee
  
  public
  def self.i18n_trip_types(hash = {})
    trip_types.key.each { |key| hash[I18n.t("")]}
  end
  
  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: user_id, source: stripe_card_token)  
      self.stripe_customer_token = customer.id
#      charge = Stripe::Charge.create(amount: 400, currency: "hkd", description: "Test",  source: stripe_card_token)
#      self.stripe_charge_token = charge.id   
      save! 
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  
  private
    def calculate_fee
      self.fee = (self.duration + 1) * 220
    end 
  
end
