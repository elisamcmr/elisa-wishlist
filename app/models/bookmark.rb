class Bookmark < ApplicationRecord
  belongs_to :item
  belongs_to :list

  validates :item, uniqueness: { scope: :list }
end
