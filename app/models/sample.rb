class Sample < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validate :start_end_check

  def start_end_check
    errors.add(:end_time,"は開始時刻と同じかそれより後の時刻でなければいけません") unless
    self.start_time <= self.end_time
  end
end
