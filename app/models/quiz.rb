class Quiz < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  validates :name, presence: true, length: { minimum: 4 }
end
