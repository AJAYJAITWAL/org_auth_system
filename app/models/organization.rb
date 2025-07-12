class Organization < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, presence: true

  scope :with_most_members, -> { joins(:memberships).group(:id).order('count(memberships.id) DESC') }

  def admin_users
    users.joins(:memberships).where(memberships: { role: "admin" })
  end
end
