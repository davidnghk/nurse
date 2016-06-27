Rails.application.routes.draw do
   scope "(:locale)", locale: /en|zh/ do
     resources :bookings
     resources :bookings do
       member do
         put :cancel    #-> domain.com/bookings/:id/cancel
         put :engage    #-> domain.com/bookings/:id/engage       
         put :disengage #-> domain.com/bookings/:id/disengage         
         put :complete  #-> domain.com/bookings/:id/complete
         put :reject    #-> domain.com/bookings/:id/reject
       end
     end
    # mount Upmin::Engine => '/admin'
	#  root to: 'visitors#index'
    root to: 'visitors#LetsNurse'
    devise_for :users
    resources :users
    resources :orders
    resources :orders do 
      collection do 
        get :open
      end
    end
  end
end
