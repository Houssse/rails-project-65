# frozen_string_literal: true

module Web
  class ProfileController < ApplicationController
    include AuthenticationConcern

    def index
      @q = current_user.bulletins.ransack(params[:q])
      @bulletins = @q.result(distinct: true)
                     .order(created_at: :desc)
                     .page(params[:page])
                     .per(25)
    end
  end
end
