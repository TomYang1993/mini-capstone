class Image < ApplicationRecord
  belongs_to :products

  validates :link, presence: true
end
