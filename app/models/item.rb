class Item < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :lists, through: :bookmarks
  has_many_attached :images
  accepts_nested_attributes_for :bookmarks

  validates :name, presence: true
  validates :url, presence: true, uniqueness: true

  # Default value for bought
  after_initialize :set_default_bought, if: :new_record?

  private

  def set_default_bought
    self.bought ||= false
  end
end
