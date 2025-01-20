# frozen_string_literal: true

class AddUniqueIndexToField < ActiveRecord::Migration[7.2]
  def change
    add_index :users, :email, unique: true
  end
end
