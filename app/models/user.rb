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
    return 0 unless date_of_birth.present?
    ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end

  def minor?
    age < 18
  end

  def membership_for(org)
    memberships.find_by(organization: org)
  end

  private

  def require_parental_consent
    return if date_of_birth.blank?

    if minor? && !parental_consent_given
      errors.add(:parental_consent_given, "is required for users under 18")
    end
  end
end
