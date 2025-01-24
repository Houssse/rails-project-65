# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      include AASM
      before_action :set_bulletin, except: :index

      def index
        authorize Bulletin
        @q = Bulletin.ransack(params[:q])
        @bulletins = @q.result(distinct: true)
                       .includes(:user)
                       .order(created_at: :desc)
                       .page(params[:page])
                       .per(25)
        render params[:template] || :index
      end

      def publish
        authorize @bulletin
        @bulletin.approve!
        redirect_to request.url, notice: I18n.t('controllers.web.admin.bulletins.notice.publish')
      end

      def reject
        authorize @bulletin
        @bulletin.reject!
        redirect_to request.url, notice: I18n.t('controllers.web.admin.bulletins.notice.reject')
      end

      def archive
        authorize @bulletin
        @bulletin.archive!
        redirect_to request.url, notice: I18n.t('controllers.web.admin.bulletins.notice.archive')
      end

      private

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end
    end
  end
end
