FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Event #{n}" }
    organiser { association :user }
    start { Time.current }
    self.end { Time.current + 1.hour }
    participants_limit { 10 }

    trait :with_participants do
      after(:create) do |event|
        create_list(:event_participant, 3, event:)
      end
    end
  end

  factory :event_participant do
    association :event
    association :user
  end
end
