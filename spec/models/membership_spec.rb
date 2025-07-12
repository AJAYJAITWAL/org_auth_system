require 'rails_helper'

RSpec.describe Membership, type: :model do
  describe "validations" do
    it { should validate_presence_of(:role) }
    it { should define_enum_for(:role).with_values(%i[member admin]) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:organization) }
  end

  describe "scopes" do
    it "has a working scope for admin" do
      org = create(:organization)
      admin = create(:membership, organization: org, role: :admin)
      member = create(:membership, organization: org, role: :member)

      expect(Membership.admin).to include(admin)
      expect(Membership.admin).not_to include(member)
    end
  end
end
