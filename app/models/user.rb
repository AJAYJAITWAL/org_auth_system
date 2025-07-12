class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships
  has_many :organizations, through: :memberships

  validates :date_of_birth, presence: true
  validate :require_parental_consent, if: :minor?

  def age
    ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end

  def minor?
    age < 18
  end

  private

  def require_parental_consent
    errors.add(:base, "Parental consent required") unless parental_consent_given?
  end
end
