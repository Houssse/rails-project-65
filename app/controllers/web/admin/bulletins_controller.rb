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
        if @bulletin.may_publish?
          @bulletin.publish!
          redirect_to request.url, notice: I18n.t('controllers.web.admin.bulletins.notice.publish')
        else
          redirect_to request.url, notice: I18n.t('')
        end
      end

      def reject
        authorize @bulletin

        if @bulletin.may_reject?
          @bulletin.reject!
          redirect_to request.url, notice: I18n.t('controllers.web.admin.bulletins.notice.reject')
        else
          redirect_to request.url, notice: I18n.t('')
        end
      end

      def archive
        authorize @bulletin
        if @bulletin.may_archive?
          @bulletin.archive!
          redirect_to request.url, notice: I18n.t('controllers.web.admin.bulletins.notice.archive')
        else
          redirect_to request.url, notice: I18n.t('')
        end
      end

      private

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end
    end
  end
end
