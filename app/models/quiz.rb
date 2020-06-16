class Quiz < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  validates :name, presence: true, length: { minimum: 4 }

  private
    def generate_slug
      parameterize_slug = self.name.parameterize
      index = 0
      loop do
        break unless Quiz.exists?( slug: parameterize_slug ) if index == 0
        break unless Quiz.exists?( slug: parameterize_slug+"-"+index )
        index++
      end
    end
end
