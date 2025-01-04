# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      # Получаем данные о пользователе от OmniAuth
      auth_data = request.env['omniauth.auth']

      # Ищем или создаём пользователя на основе данных из GitHub
      user = User.find_or_initialize_by(email: auth_data['info']['email'])
      user.name = auth_data['info']['name'] || user.name
      user.save!

      # Сохраняем ID пользователя в сессии (он считается "вошедшим")
      session[:user_id] = user.id

      # Перенаправляем на главную страницу с сообщением об успехе
      redirect_to root_path, notice: "Добро пожаловать, #{user.name}!"
    rescue StandardError => e
      # В случае ошибки выводим сообщение
      redirect_to root_path, alert: "Ошибка входа: #{e.message}"
    end

    def destroy
      # Удаляем данные о пользователе из сессии (выход)
      session[:user_id] = nil
      redirect_to root_path, notice: 'Вы вышли.' # rubocop:disable Rails/I18nLocaleTexts
    end
  end
end
