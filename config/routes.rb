Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'items#index'

  resources :items do
    member do
      get 'category' # カテゴリー一覧表示
      get 'brand' # ブランド一覧表示
    end
  end
  resources :transactions, only: [:edit, :update]
  resources :users, only: [:index, :show, :edit, :update] do
    collection do
      get 'logout'
    end
    member do
      get 'profile' # プロフィール
    end
  end
  resources :signup do
    collection do
      get 'selection' # 分岐
      get 'personal' # 会員情報を入力
      get 'phone' # 電話番号認証
      get 'address' # 住所入力
      get 'card' # 支払い方法
      get 'done' # 完了画面
      post 'pay', to: 'signup#pay'
    end
  end
  resources :cards, only: [:index, :new, :show] do
    collection do
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end
end
