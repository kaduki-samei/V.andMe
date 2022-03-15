Rails.application.routes.draw do

  namespace :admin do
    get 'tags/index'
  end
  # 管理者側
  devise_for :admin, skip: [:registrations], controllers: {
  sessions: "admin/sessions",
  passwords: "admin/passwords",
}
  devise_scope :admin do
    get '/admin/sign_out' => 'admin/sessions#destroy'
  end
  namespace :admin do
    resources :users, only:[:index, :show, :update]
    resources :posts, only:[:index, :show, :destroy]
    resources :post_comments, only:[:destroy]
    resources :tags, only:[:index, :destroy]
  end


  # ユーザー側
  devise_for :users, controllers: {
  sessions: "public/sessions",
  passwords: "public/passwords",
  registrations: "public/registrations"
}
  devise_scope :user do
    get '/users/sign_out' => 'public/sessions#destroy'
  end
  scope module: :public do
    root "homes#top"
    get "/about" => "homes#about"
    resources :users, only:[:show, :edit, :update] do
      collection do
        get "quit"
        patch "out"
      end
    end
    resources :posts do
      collection do
        post "new_confirm"
        post :new, path: :new, as: :new_back, action: :new_back
      end
      member do
        patch 'edit_confirm'
        patch :edit, path: :edit, as: :edit_back, action: :edit_back
      end
    end
    resources :post_comments, only:[:create, :destroy]
    resources :follows, only:[:index, :create, :destroy]
    resources :nices, only:[:create, :destroy]
    resources :bookmarks, only:[:index, :create, :destroy]
    resources :messages, only:[:new, :create] do
      collection do
        get "confirm"
        get "thanx"
      end
    end
    get "/searches" => "searches#search"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
