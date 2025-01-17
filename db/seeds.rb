# frozen_string_literal: true

Rails.logger.debug 'Очистка базы данных'

Rake::Task['db:clean'].invoke

Rails.logger.debug 'Заполнение базы данных...'

image_files = Dir['./public/images/*.jpg']

40.times do
  user = User.create!(name: Faker::Name.name, email: Faker::Internet.email)
  image = File.open(image_files.sample)
  category_name = Faker::Commerce.department(max: 1)
  category = Category.find_or_create_by!(name: category_name)

  Bulletin.create(title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph,
                  user: user, category: category, image: image)
  image.close
end

Rails.logger.debug 'Готово'
