# frozen_string_literal: true

module Web
  class BulletinsControllerTest < ActionDispatch::IntegrationTest
    def setup
      @category = categories(:one)
      @bulletin = bulletins(:one)
      @user = users(:one)
      sign_in(@user)
    end

    test 'should create bulletin' do
      params = {
        bulletin: {
          title: 'New bulletin',
          description: 'Description',
          category_id: @category.id,
          image: fixture_file_upload(Rails.root.join('test/fixtures/files/test_image.jpg'),
                                     'image/jpg')
        }
      }

      post(bulletins_path, params:)
      @new_bulletin = Bulletin.find_by(title: 'New bulletin')

      assert(@new_bulletin)
    end

    test 'should update bulletin' do
      updated_params = {
        bulletin: {
          title: 'Updated title',
          description: 'Updated description',
          category_id: @category.id,
          image: fixture_file_upload(Rails.root.join('test/fixtures/files/test_image.jpg'),
                                     'image/jpg')
        }
      }

      patch bulletin_path(@bulletin), params: updated_params
      @bulletin.reload

      assert_equal 'Updated title', @bulletin.title
      assert_equal 'Updated description', @bulletin.description
    end
  end
end
