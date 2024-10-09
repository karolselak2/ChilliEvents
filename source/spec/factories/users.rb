FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "John #{n}" }
    last_name { 'Smith' }
    sequence(:email) { |n| "johnsmith#{n}@example.com" }

    trait :with_3_events_participated do
      after(:create) do |user|
        create_list(:event_participant, 3, user:)
      end
    end

    trait :with_3_events_organised do
      after(:create) do |user|
        create_list(:event, 3, organiser: user)
      end
    end
  end
end
