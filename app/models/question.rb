class Question < ApplicationRecord
  belongs_to :quiz
  validates :description, presence: true, length: { minimum: 7 }
  validates :options, presence: true
end
