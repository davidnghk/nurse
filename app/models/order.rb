class Order < ActiveRecord::Base
  default_scope { order('call_date DESC') }

  scope :history, -> { where(role: :manager)}
  scope :history, lambda{ where("repair_date < ?", Date.today) }
  
  include AASM
  
  belongs_to :store
  belongs_to :device
  belongs_to :issue
  belongs_to :work
  belongs_to :technician, :class_name => 'User', :foreign_key => 'technician_id'
  
  mount_uploader :image_01, ImageUploader
  mount_uploader :image_02, ImageUploader
  mount_uploader :image_03, ImageUploader
  mount_uploader :image_04, ImageUploader
  
  validates_presence_of :call_date, :store, :repair_date, :status, :device, :issue, :technician
  
  enum status: [:Open, :Acknowledged, :Cancelled, :Completed, :FollowUp, :Escalated, :Photographed]
  

  has_attached_file :photo, styles: { large: "800x600>", thumb: "200x150>" }
  validates_attachment_content_type :photo, :content_type => 'image/jpeg'
  
  has_attached_file :photo_02, styles: { large: "800x600>", thumb: "200x150>" }
  validates_attachment_content_type :photo_02, :content_type => 'image/jpeg'
  
  has_attached_file :photo_03, styles: { large: "800x600>", thumb: "200x150>" }
  validates_attachment_content_type :photo_03, :content_type => 'image/jpeg'
  
  has_attached_file :photo_04, styles: { large: "800x600>", thumb: "200x150>" }
  validates_attachment_content_type :photo_04, :content_type => 'image/jpeg'
  
  has_attached_file :photo_05, styles: { large: "800x600>", thumb: "200x150>" }
  validates_attachment_content_type :photo_05, :content_type => 'image/jpeg'
  
  
  
  has_attached_file :document_01, styles: { large: "800x600>", thumb: "100x75>" }
  validates_attachment_content_type :document_01, :content_type => ['image/jpg', 'image/png', 'application/pdf']
  has_attached_file :document_02, styles: { large: "800x600>", thumb: "100x75>" }
  validates_attachment_content_type :document_02, :content_type => ['image/jpg', 'image/png', 'application/pdf']
  
  has_attached_file :document_03, styles: { large: "800x600>", thumb: "100x75>" }
  validates_attachment_content_type :document_03, :content_type => ['image/jpg', 'image/png', 'application/pdf']
  
  has_attached_file :document_04, styles: { large: "800x600>", thumb: "100x75>" }
  validates_attachment_content_type :document_04, :content_type => ['image/jpg', 'image/png', 'application/pdf']
  
  has_attached_file :document_05, styles: { large: "800x600>", thumb: "100x75>" }
  validates_attachment_content_type :document_05, :content_type => ['image/jpg', 'image/png', 'application/pdf']
  
  aasm(:status) do
    state :Open, :initial => true
    
    state :Acknowledged, :Cancelled, :Completed, :FollowUp, :Escalated, :Photographed

    event :acknowledge do
      transitions :from => [:Open, :ReOpen], :to => :Acknowledged
    end
  
    event :photograph do
      transitions :from => :Acknowledged, :to => :Photographed
    end
    
    event :followup do
      transitions :from => [:Acknowledged, :Photographed], :to => :FollowUp
    end
    
    event :escalate do
      transitions :from => [:Acknowledged, :Photographed], :to => :Escalated
    end
  
    event :cancel do
      transitions :from => [:Open, :Acknowledged, :Escalated], :to => :Cancelled
    end
  
    event :complete do
      transitions :from => [:Acknowledged, :Photographed], :to => :Completed
    end
    
    event :reopen do
      transitions :from => [:Acknowledged, :FollowUp, :Escalated], :to => :Open
    end
  end
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << [
          "Call Date",
          "Client",
          "Store Code", 
          "Store Name", 
          "Job No", 
          "Repair Date", 
          "Status", 
          "Device", 
          "Issue"     
        ]
      all.each do |order|
        csv << [
          order.call_date.strftime("%d-%m-%Y"),
          order.store.client.name,
          order.store.code,
          order.store.name, 
          order.user_ref,
          order.repair_date.strftime("%d-%m-%Y"),
          order.status,
          order.device.name, 
          order.issue.name      
        ]
        
        #csv << order.attributes.values_at(*column_names)
      end
    end
  end
  
  def self.i18n_statuses(hash = {})
    statuses.keys.each { |key| hash[I18n.t("statuses.#{key}")] = key }
    hash
  end
  
  def self.to_label
  end 
  
  def self.rollover
    today = Date.today
    if !today.sunday?
      @order = Order.Open.each do |o|
        o.acknowledge!
      end
      @order = Order.Acknowledged.each do |o|
        puts o.store.name
        o.acknowledgement_datetime = nil
        o.repair_date = Date.today
        o.reopen!
        OrderMailer.delay.new_order_to_repairman(o)
      end
      @order = Order.FollowUp.each do |o|
        puts o.store.name
        o.acknowledgement_datetime = nil
        o.repair_date = Date.today
        o.reopen!
        OrderMailer.delay.new_order_to_repairman(o)
      end
      @order = Order.Escalated.each do |o|
        puts o.store.name
        o.acknowledgement_datetime = nil
        o.repair_date = Date.today
        o.reopen!
        OrderMailer.delay.new_order_to_repairman(o)
      end
    end
  end
  
end
