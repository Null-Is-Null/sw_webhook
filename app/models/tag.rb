class Tag < ApplicationRecord
  validates :name, presence: true

  before_validation do
    self.name.downcase!
  end
end
