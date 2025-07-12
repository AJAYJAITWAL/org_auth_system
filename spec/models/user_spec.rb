require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:date_of_birth) }
  end

  describe "associations" do
    it { should have_many(:memberships).dependent(:destroy) }
    it { should have_many(:organizations).through(:memberships) }
  end

  describe "#age" do
    it "calculates correct age" do
      user = build(:user, date_of_birth: 20.years.ago.to_date)
      expect(user.age).to be_within(1).of(20)
    end
  end

  describe "#minor?" do
    it "returns true if user is under 18" do
      user = build(:user, date_of_birth: 10.years.ago.to_date)
      expect(user.minor?).to be true
    end

    it "returns false if user is 18 or older" do
      user = build(:user, date_of_birth: 20.years.ago.to_date)
      expect(user.minor?).to be false
    end
  end

  describe "#parental_consent_given?" do
    it "returns true if user is adult (no need for consent)" do
      user = build(:user, date_of_birth: 25.years.ago.to_date)
      expect(user.parental_consent_given?).to be true
    end

    it "returns true if user is minor and consent given" do
      user = build(:user, date_of_birth: 16.years.ago.to_date, parental_consent_given: true)
      expect(user.parental_consent_given?).to be true
    end

    it "returns false if user is minor and consent not given" do
      user = build(:user, date_of_birth: 16.years.ago.to_date, parental_consent_given: false)
      expect(user.parental_consent_given?).to be false
    end
  end
end
