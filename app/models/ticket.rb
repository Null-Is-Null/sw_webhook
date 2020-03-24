class Ticket < ApplicationRecord
  has_and_belongs_to_many :tags
  validates :user_id, numericality: { only_integer: true }
  validates :title, presence: true
  validates :tags, length: { maximum: 5, too_long: "A maximum of five tags may be specified" }
  validate :tags_cannot_have_duplicates
  validates_associated :tags, message: "One or more tags are empty"

  before_create do
    self.tags.each do |tag|
      Tag.find_by(name: tag.name)&.increment!(:count)
    end
  end

  def tags_cannot_have_duplicates
    if tags.uniq do |tag| tag.name end .length != tags.length
      errors.add(:tags, "A ticket cannot have duplicate tags")
    end
  end
end
