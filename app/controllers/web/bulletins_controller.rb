# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    include AuthenticationConcern
    include AASM

    before_action :set_bulletin, only: %i[send_to_moderation archive]
    before_action :authenticate_user!, only: %i[new create edit update]

    def index
      @q = Bulletin.ransack(params[:q])
      @bulletins = @q.result(distinct: true)
                     .includes(:user)
                     .published
                     .order(created_at: :desc)
                     .page(params[:page])
                     .per(12)
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def new
      authorize Bulletin
      @bulletin = Bulletin.new
      @categories = Category.all
    end

    def edit
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      @categories = Category.all
    end

    def create
      authorize Bulletin
      @bulletin = Bulletin.new(bulletin_params)
      @bulletin.user = current_user
      @categories = Category.all

      if @bulletin.save
        redirect_to profile_path, notice: I18n.t('controllers.web.bulletins.notice.create')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @categories = Category.all
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin

      if @bulletin.update(bulletin_params)
        redirect_to profile_path, notice: I18n.t('controllers.web.bulletins.notice.update')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def send_to_moderation
      authorize @bulletin
      if @bulletin.may_submit?
        @bulletin.submit!
        redirect_to profile_path, notice: I18n.t('controllers.web.bulletins.notice.send_to_moderation')
      else
        redirect_to profile_path, notice: I18n.t('')
      end
    end

    def archive
      authorize @bulletin
      if @bulletin.may_archive?
        @bulletin.archive!
        redirect_to profile_path, notice: I18n.t('controllers.web.bulletins.notice.archive')
      else
        redirect_to profile_path, notice: I18n.t('')
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end

    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end
  end
end
