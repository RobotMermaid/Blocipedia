

    require 'faker'

    10.times do
        User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: "nothing"
      )
    end

    50.times do
      Wiki.create!(
              title: Faker::ChuckNorris.fact,
              body: Faker::Hacker.say_something_smart,
              private: Faker::Boolean.boolean(0.3),
              user_id: Faker::Number.between(1, 50)
      )
    end


    puts 'tis done'
    puts "#{User.count} users created"
    puts "#{Wiki.count} wikis created"
