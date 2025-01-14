# frozen_string_literal: true

namespace :db do
  desc 'Clear all data, reset IDs, but keep ar_internal_metadata and clear attachments'
  task clean: :environment do
    # Очистка данных в таблицах
    ActiveRecord::Base.connection.tables.each do |table|
      next if table == 'schema_migrations' || table == 'ar_internal_metadata' # rubocop:disable Style/MultipleComparison

      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE")
      puts "Cleared and reset IDs for table: #{table}"
    end

    # Очистка локальных файлов, связанных с ActiveStorage
    ActiveStorage::Blob.find_each do |blob|
      # Удаляем файл с диска
      blob.purge
      puts "Purged attachment for: #{blob.filename}"
    end

    # Очищаем локальное хранилище от файлов, которые больше не используются
    storage_dir = Rails.root.join('storage')

    # Удаляем файлы, которые больше не используются
    Dir.glob("#{storage_dir}/**/*").each do |file|
      if File.file?(file) && !ActiveStorage::Blob.exists?(filename: File.basename(file))
        File.delete(file)
        puts "Deleted orphan file: #{file}"
      end
    end

    # Удаляем пустые каталоги
    Dir.glob("#{storage_dir}/**/").reverse_each do |dir|
      if Dir.empty?(dir)
        Dir.rmdir(dir)
        puts "Deleted empty directory: #{dir}"
      end
    end
  end
end
