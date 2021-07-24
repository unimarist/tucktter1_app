FactoryBot.define do
  factory :user do
    Nickname              {Faker::Name.initials(number: 3)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
  end
end