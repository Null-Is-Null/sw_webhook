class Ticket < ApplicationRecord
  has_and_belongs_to_many :tags
  validates :user_id, numericality: { only_integer: true }
  validates :title, presence: true
  validates :tags, length: { maximum: 5 }

  before_create do
    self.tags.each do |tag|
      Tag.find_by(name: tag.name)&.increment!(:count)
    end
  end
end
