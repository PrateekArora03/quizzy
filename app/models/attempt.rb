class Attempt < ApplicationRecord
  has_many :attempt_answers, dependent: :destroy
  belongs_to :user
  belongs_to :quiz
  validates :submitted, :inclusion => {:in => [true, false]}
  validates :correct_answers_count, presence: true
  validates :incorrect_answers_count, presence: true

  scope :submitted_attempts, -> { where(submitted: true) }
end
