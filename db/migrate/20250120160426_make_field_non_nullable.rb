# frozen_string_literal: true

class MakeFieldNonNullable < ActiveRecord::Migration[7.2]
  def up
    change_table :bulletins, bulk: true do |t|
      t.change :title, :string, null: false
      t.change :description, :text, null: false
      t.change :state, :string, null: false
    end

    change_column_null :users, :email, false
  end

  def down
    change_table :bulletins, bulk: true do |t|
      t.change :title, :string, null: true
      t.change :description, :text, null: true
      t.change :state, :string, null: true
    end

    change_column_null :users, :email, true
  end
end
