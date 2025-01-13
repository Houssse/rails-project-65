# frozen_string_literal: true

namespace :db do
  desc 'Clear all data, reset IDs, but keep ar_internal_metadata'
  task clean: :environment do
    ActiveRecord::Base.connection.tables.each do |table|
      next if table == 'schema_migrations' || table == 'ar_internal_metadata' # rubocop:disable Style/MultipleComparison

      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE")
      puts "Cleared and reset IDs for table: #{table}"
    end
  end
end
