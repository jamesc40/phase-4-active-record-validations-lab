class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { minimum: 250 } 
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  validate :check_for_clickbait?

  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top \d/i,
    /Guess/i
  ]

  def check_for_clickbait?
    if CLICKBAIT_PATTERNS.none? { |string| string.match title }
      errors.add(:title, 'must be clickbait')
    end
  end
end
