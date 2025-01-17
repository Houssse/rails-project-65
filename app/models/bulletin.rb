# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  aasm column: 'state' do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :submit do
      transitions from: :draft, to: :under_moderation
    end

    event :approve do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft published rejected under_moderation], to: :archived
    end
  end

  has_one_attached :image
  include ImageValidations

  belongs_to :user
  belongs_to :category

  validates :category_id, numericality: { only_integer: true }
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
end
