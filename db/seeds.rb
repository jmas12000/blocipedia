

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
  email:    Faker::Internet.unique.email ,
  password: Faker::Internet.password,
  role:     'admin'
)
 

puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"