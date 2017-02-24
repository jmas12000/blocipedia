FactoryGirl.define do
  factory :wiki do
    title "MyString"
    body "MyText is for the factory Wiki body"
    user 
    private false
  end
end
