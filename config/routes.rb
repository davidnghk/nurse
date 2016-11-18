Rails.application.routes.draw do
  scope "(:locale)", locale: /en|zh/ do
    resources :works
    resources :issues
    resources :devices
    resources :districts
    resources :clients
    resources :stores do
      collection { post :import }
    end
    resources :orders do 
       member do
         put :cancel          #-> domain.com/orders/:id/cancel
         put :acknowledge     #-> domain.com/orders/:id/acknowledge   
         put :photograph      #-> domain.com/orders/:id/complete
         put :complete        #-> domain.com/orders/:id/complete
         put :followup        #-> domain.com/orders/:id/followup
         put :escalate        #-> domain.com/orders/:id/escalate
         put :reopen          #-> domain.com/orders/:id/escalate
         get :download         #-> domain.com/orders/:id/escalate
         put :delete_photo    #-> domain.com/orders/:id/escalate
       end
     end
     resources :bookings
     resources :bookings do
       resources :charges 
       member do
         put :cancel    #-> domain.com/bookings/:id/cancel
         put :engage    #-> domain.com/bookings/:id/engage       
         put :disengage #-> domain.com/bookings/:id/disengage  
         put :confirm   #-> domain.com/bookings/:id/confirm 
         put :complete  #-> domain.com/bookings/:id/complete
         put :reject    #-> domain.com/bookings/:id/reject
         put :expire    #-> domain.com/bookings/:id/reject
       end
     end
     # mount Upmin::Engine => '/admin'
	 # root to: 'visitors#index'
     root to: 'visitors#mos'
     get "customer_faq" => "visitors#faq"
     get "partner_faq"  => "visitors#faq2"
     get "about"  => "visitors#about"
     devise_for :users 
     resources :users
        resources :orders do 
       collection do 
        get :open
      end
    end
  end
end
