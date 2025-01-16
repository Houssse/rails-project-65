# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'web' do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'logout', to: 'auth#destroy', as: :logout

    resources :bulletins, only: %i[index show new create]

    scope module: 'admin', path: 'admin' do
      resources :categories, except: :show
    end
  end

  root 'web/bulletins#index'

  get '/manifest.json', to: ->(_) { [204, {}, []] }
end
