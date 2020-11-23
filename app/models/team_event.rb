class TeamEvent < ApplicationRecord
  belongs_to :team

  validates :title, presence: true, length: { maximum: 20 }
end
