class Website < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true, uniqueness: true
  validates :category, presence: true
end 
