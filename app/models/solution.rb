class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :problem

  validate do |solution|
    solution.valid_language
  end
    
  def valid_language
    langs = ["python", "c", "javascript", "ruby"]
    errors.add(:base, 'Invalid Language') if !(langs.include? language)
  end
end
