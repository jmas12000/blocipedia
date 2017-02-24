FactoryGirl.define do
  pw = "123456"
  
  factory :user do
    sequence(:email){|n| "user#{n}@factory.com" }
    password pw
    role :standard
  end
end
