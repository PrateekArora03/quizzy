class Attempt < ApplicationRecord
  has_many :attempt_answers, dependent: :destroy
  belongs_to :user
  belongs_to :quiz
  validates :submitted, :inclusion => {:in => [true, false]}
end
