require 'random_data'

5.times do
  User.create!(
  email:    RandomData.random_email,
  password: RandomData.random_sentence
  )
end
users = User.all

50.times do
  Wiki.create!(
    user:   users.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end
wikis = Wiki.all

puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"