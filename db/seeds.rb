
  task :fake_users => :environment do
    require 'faker'

    30.times do
        User.create!(
        username: Faker::Internet.user_name,
        email: Faker::Internet.email,
        user_id: Faker::Number.between(1, 25),
        password: Faker::Internet.password,

        confirmed_at: Faker::Time.between(10.days.ago, Date.today, :all)
      )
    end

    50.times do
      Wiki.create!(
              title: Faker::ChuckNorris.fact,
              body: Faker::Hipster.paragraph,
              private: false,
              id: Faker::Number.between(1, 25)
      )
    end
    puts 'tis done'
  end
