# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'web' do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'logout', to: 'auth#destroy', as: :logout

    # Bulletin routes
    resources :bulletins, except: :destroy do
      member do
        patch :send_to_moderation
        patch :archive
      end
    end

    # Profile routes
    get '/profile', to: 'profile#index'

    # Admin routes
    scope module: 'admin', path: 'admin' do
      resources :categories, except: :show
      get '/', to: 'bulletins_on_moderation#index', as: 'bulletins_on_moderation'
      resources :bulletins, only: [] do
        member do
          patch :published
          patch :rejected
          patch :archive, as: 'archive_admin'
        end
      end
    end
  end

  root 'web/bulletins#index'

  get '/manifest.json', to: ->(_) { [204, {}, []] }
end
