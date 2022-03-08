Rails.application.routes.draw do

  namespace :admin do
    get 'tags/index'
  end
  # 管理者側
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
    resources :users, only:[:index, :show, :update]
    resources :posts, only:[:index, :show, :destroy]
    resources :post_comments, only:[:destroy]
    resources :tags, only:[:index, :destroy]
  end

  devise_scope :admin do
    get "/admin/sign_out" => "devise/sessions#destroy"
  end


  # ユーザー側
  devise_for :users, controllers: {
  sessions: "public/sessions",
  passwords: "public/passwords",
  registrations: "public/registrations"
}

  scope module: :public do
    root "homes#top"
    get "/about" => "homes#about"
    resources :users, only:[:show, :edit, :update]
    resources :posts do
      collection do
        get "new_confirm"
        get "edit_confirm"
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
