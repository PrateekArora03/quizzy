class Quiz < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { minimum: 4 }
end
