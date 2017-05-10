Rails.application.routes.draw do
  devise_for :users
	namespace :api, defaults: { format: 'json' } do
		namespace :v1 do
			resources :histories, only: %i(index)
			resources :lcbo_products, only: %i(index show)
		end
	end

  root controller: 'page', action: 'index'
end
