

10.times do
  User.create!(
  email:    Faker::Internet.unique.email ,
  password: Faker::Internet.password
  )
end
users = User.all

50.times do
  Wiki.create!(
    user:   users.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
  )
end
wikis = Wiki.all

admin = User.create!(
  email:    "j@admin.com" ,
  password: "password",
  role:     'admin'
)

standard = User.create!(
  email:    "j@standard.com" ,
  password: "password",
  role:     'standard'
)

premium = User.create!(
  email:    "j@premium.com" ,
  password: "password",
  role:     'premium'
)


 

puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"