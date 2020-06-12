class Question < ApplicationRecord
  belongs_to :quiz
  validates :description, presence: true, length: { minimum: 7 }
  validates :options, presence: true
  validates :correct_answer, presence: true, inclusion : 1..4
end
