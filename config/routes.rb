Rails.application.routes.draw do
  devise_for :users
  root 'graphs#index'
  # resource「s」ではない！（updateに「:id」は不要だから） updateに:idがなくてもできる
  resource :graphs, only: %i[index create update]
end
