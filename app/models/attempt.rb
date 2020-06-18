class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  validates :submitted, presence: true, inclusion: { in: %w[true false] }
end
