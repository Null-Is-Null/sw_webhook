class Tag < ApplicationRecord
  has_and_belongs_to_many :tickets
  validates :name, presence: true

  before_validation do
    self.name&.downcase!
  end

end
