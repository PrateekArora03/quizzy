class Attempt < ApplicationRecord
  has_one :attempt_answers, dependent: :destroy
  belongs_to :user
  belongs_to :quiz
  validates :submitted, presence: true, inclusion: { in: %w[true false] }
end
