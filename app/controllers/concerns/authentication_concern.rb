# frozen_string_literal: true

module AuthenticationConcern
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
    before_action :authenticate_user!
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    redirect_to root_path, alert: 'Пожалуйста, войдите в систему' unless current_user # rubocop:disable Rails/I18nLocaleTexts
  end
end
