Rails.application.routes.draw do
  
  devise_for :users ,controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'sessions' }
  resources :posts do 
    collection do 
      post :create_comment
      delete :destroy_comment
      post :like_dislike
      delete :like_dislike
      post :like_post
    end
  end


  root "homes#index"
  get 'homes/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
