# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < Web::Admin::ApplicationController
      before_action :find_category, only: %i[edit update destroy]

      def index
        authorize Category
        @categories = Category.all
      end

      def new
        authorize Category
        @category = Category.new
      end

      def edit; end

      def create
        authorize Category
        @category = Category.new(category_params)

        if @category.save
          redirect_to admin_categories_path, notice: I18n.t('controllers.web.admin.categories.notice.create')
        else
          render :new, status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          redirect_to admin_categories_path, notice: I18n.t('controllers.web.admin.categories.notice.update')
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        if @category.bulletins.present?
          redirect_to admin_categories_path, notice: I18n.t('controllers.web.admin.categories.notice.error')
        else
          @category.destroy
          redirect_to admin_categories_path, notice: I18n.t('controllers.web.admin.categories.notice.delete')
        end
      end

      private

      def find_category
        @category = Category.find(params[:id])
        authorize @category
      end

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
