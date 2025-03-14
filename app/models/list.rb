class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :items, through: :bookmarks

  validates :name, presence: true
end
