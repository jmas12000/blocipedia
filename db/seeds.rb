

1.times do
  User.create!(
  email:    "random@example.com",
  password: "12345678"
  )
end
users = User.all

50.times do
  Wiki.create!(
    user:   users.sample,
    title:  "Wiki title",
    body:   "Wiki body"
  )
end
wikis = Wiki.all

admin = User.create!(
  email:    'admin@example.com',
  password: 'password',
  role:     'admin'
)
 

puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"