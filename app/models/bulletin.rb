# frozen_string_literal: true

class Bulletin < ApplicationRecord
  has_one_attached :image
  include ImageValidations

  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
end
