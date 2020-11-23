class TeamEvent < ApplicationRecord
  belongs_to :team

  validates :title, presence: true, length: { maximum: 20 }
  validate :start_end_check

  def start_end_check
    errors.add(:end_time, 'は開始時刻と同じか、それより後の時刻でなければいけません') unless
    start_time <= end_time
  end
end
