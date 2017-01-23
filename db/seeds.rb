

    require 'faker'

    10.times do
        User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: Faker::Internet.password
      )
    end

    50.times do
      Wiki.create!(
              title: Faker::ChuckNorris.fact,
              body: Faker::Hacker.say_something_smart,
              private: false,
              user_id: Faker::Number.between(1, 10)
      )
    end

    puts 'tis done'
    puts "#{User.count} users created"
    puts "#{Wiki.count} wikis created"
