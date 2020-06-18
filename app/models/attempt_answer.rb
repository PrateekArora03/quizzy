class AttemptAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :attempt
  validates :submitted_option, presence: true
end
