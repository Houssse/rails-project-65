# frozen_string_literal: true

module ImageValidations
  extend ActiveSupport::Concern

  included do
    validate :validate_image
  end

  private

  def validate_image
    if image.attached?
      allowed_types = %w[image/jpeg image/png]
      errors.add(:image, 'must be a JPEG, PNG') unless allowed_types.include?(image.content_type)

      max_size = 5.megabytes
      errors.add(:image, 'must be less than 5MB') if image.byte_size > max_size
    else
      errors.add(:image, 'is required')
    end
  end
end
