# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      include AASM
      before_action :set_bulletin, except: :index

      def index
        authorize Bulletin
        @bulletins = Bulletin.includes(:user)
      end

      def published
        authorize @bulletin
        @bulletin.approve!
        redirect_to request.url
      end

      def rejected
        authorize @bulletin
        @bulletin.reject!
        redirect_to request.url
      end

      def archive
        authorize @bulletin
        @bulletin.archive!
        redirect_to request.url
      end

      private

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end
    end
  end
end
