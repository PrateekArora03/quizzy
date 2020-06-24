class Question < ApplicationRecord
  belongs_to :quiz
  has_many :attempt_answers, dependent: :destroy
  validates :description, presence: true, length: { minimum: 7 }
  validates :options, presence: true
  validates :correct_answer, presence: true, inclusion: 1..4
  validates_with QuestionValidator
end
