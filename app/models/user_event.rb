class UserEvent < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 20 }
  validate :start_check

  def start_check
    if start_time == nil
      errors.add(:start_time, 'が入力されていません')
    end
  end
end
