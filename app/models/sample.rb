class Sample < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }
  # validates :start_time ,presence: true
  validate :start_check
  def start_check
    if start_time == nil
      errors.add(:start_time, 'が入力されていません')
    end
  end
end
