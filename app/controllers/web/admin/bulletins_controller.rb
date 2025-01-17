# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      include AASM
      before_action :set_bulletin

      def published
        @bulletin.approve!
        redirect_to bulletins_on_moderation_path
      end

      def rejected
        @bulletin.reject!
        redirect_to bulletins_on_moderation_path
      end

      def archive
        @bulletin.archive!
        redirect_to bulletins_on_moderation_path
      end

      private

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end
    end
  end
end
