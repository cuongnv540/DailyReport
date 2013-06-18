namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Nguyen Cuong",
                         email: "catbui7583@gmail.com",
                         password: "123456",
                         password_confirmation: "123456")
    admin.toggle!(:admin)
    admin.toggle!(:active)

    User.create!(name: "Example User",
                 email: "example@framgia.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@framgia.com"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end