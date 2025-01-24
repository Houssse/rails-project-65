# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      auth_data = request.env['omniauth.auth']

      user = User.find_or_initialize_by(email: auth_data['info']['email'])
      user.name = auth_data['info']['name'] || user.name
      user.save!

      session[:user_id] = user.id

      redirect_to root_path, notice: I18n.t('controllers.web.auth.notice.logged_in')
    rescue StandardError
      redirect_to root_path
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: I18n.t('controllers.web.auth.notice.logged_out')
    end
  end
end
