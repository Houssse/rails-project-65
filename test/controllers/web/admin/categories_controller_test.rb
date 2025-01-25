# frozen_string_literal: true

module Admin
  module Web
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      def setup
        @admin = users(:two)
        sign_in(@admin)
      end

      test 'shuld admin create category' do
        post admin_categories_path, params: { category: { name: 'new category' } }

        assert(Category.find_by(name: 'new category'))
      end

      test 'shuld admin update category' do
        category = categories(:one)
        patch admin_category_path(category), params: { category: { name: 'updated name' } }

        assert(Category.find_by(name: 'updated name'))
      end

      test 'shuld admin destroy category' do
        category = Category.create!(name: 'Test Category')

        assert Category.exists?(category.id)

        delete admin_category_path(category)

        assert_not Category.exists?(category.id)
      end
    end
  end
end
