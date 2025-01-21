# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  has_one_attached :image

  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true,
                    blob: { content_type: %i[png jpg jpeg webp],
                            size_range: 1..(5.megabytes) }

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

  def self.ransackable_attributes(_auth_object = nil)
    %w[title category_id state]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category]
  end

  def state_label
    I18n.t("activerecord.attributes.bulletin.state.#{aasm.current_state}")
  end
end
