class User::Server < ActiveRecord::Base
  include AASM
  
  aasm :profession_status => 'my_state' do
    state :pending, :initial => true
    state :approved, :rejected, :suspended

    event :approve do
      transitions :from => :pending, :to => :approved
    end

    event :reject do
      transitions :from => :pending, :to => :rejected
    end

    event :suspend do
      transitions :from => :approved, :to => :suspended
    end
    
    event :activate do
      transitions :from => :suspended, :to => :approved
    end
  end
  
end
