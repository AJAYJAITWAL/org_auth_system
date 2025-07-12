FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password123" }
    date_of_birth { 20.years.ago.to_date }
    parental_consent_given { nil }
  end
end
