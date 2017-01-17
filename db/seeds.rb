

    require 'faker'

    30.times do
        User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: Faker::Internet.password
      )
    end

    50.times do
      Wiki.create!(
              title: Faker::ChuckNorris.fact,
              body: Faker::Hipster.paragraph,
              private: false
      )
    end

    puts 'tis done'
    puts "#{User.count} users created"
    puts "#{Wiki.count} wikis created"
