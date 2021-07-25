FactoryBot.define do
  factory :research do
    research_title {Faker::Lorem.characters(number: 10)}
    research_summary {Faker::Lorem.characters(number: 30)}
    research_url {Faker::Lorem.characters(number: 40)}
    association :user 
  end
end