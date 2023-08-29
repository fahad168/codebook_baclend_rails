Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :posts do
        collection do
          get :videos
          get :shorts
        end
      end
      resources :users do
        collection do
          get :email_validate
          get :post_images
          get :post_videos
        end
      end
      resources :likes, only: :index do
        collection do
          post :like_post
          post :dislike_post
        end
      end

      resources :comments, only: :index do
        collection do
          post :create_comment
          post :create_child_comment
          get :child_comments
        end
      end

      resources :stories do
        collection do
          get :other_user_stories
        end
      end
      post '/auth/login', to: 'authentication#login'
    end
  end
end
