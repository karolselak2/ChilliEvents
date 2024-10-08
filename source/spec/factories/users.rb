FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "John #{n}" }
    last_name { "Smith" }
    sequence(:email) { |n| "johnsmith#{n}@example.com" }
  end
end