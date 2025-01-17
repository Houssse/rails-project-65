# frozen_string_literal: true

module Web
  module Admin
    class BulletinsOnModerationController < ApplicationController
      def index
        authorize Bulletin
        @bulletins = Bulletin.under_moderation
                             .page(params[:page])
                             .per(25)
      end
    end
  end
end
