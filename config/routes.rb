Rails.application.routes.draw do
  scope "(:locale)", locale: /en|zh/ do
	  # resources :bookings
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
