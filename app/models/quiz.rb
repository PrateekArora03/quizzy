class Quiz < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  validates :name, presence: true, length: { minimum: 4 }
  validates :slug, presence: true, allow_nil: true

  def generate_slug
    self.slug = self.name.parameterize
    index = 0
    loop do
      break unless Quiz.exists?( slug: self.slug )
      index = index + 1
      self.slug = "#{self.name.parameterize}-#{index}"
    end
  end
end
