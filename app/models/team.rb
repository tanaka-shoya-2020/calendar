class Team < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, authentication_keys: [:name]
  devise :registerable, :recoverable, :rememberable

  validates :name, presence: true, length: { maximum: 20 },
                   uniqueness: { case_sensitive: true }

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX

  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  has_many :team_events
end
