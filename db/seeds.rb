# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
    User.create!(
        name: "writer#{n + 1}",
        email: "writer#{n + 1}@example.com",
        password: "test",
        password_confirmation: "test", 
        admin: "false",
        role: 10
    )
end

5.times do |n|
    User.create!(
        name: "reader#{n + 1}",
        email: "reader#{n + 1}@example.com",
        password: "test",
        password_confirmation: "test", 
        admin: "false",
        role: 0
    )
end

5.times do |n|
    Novel.create!(
        user_id: 1,
        title: "test#{n + 1}",
        genre: 10,
        story_length: 5,
        plot: "test",
        release: 1
    )
end

5.times do |n|
    Novel.create!(
        user_id: 2,
        title: "test#{n + 10}",
        genre: 20,
        story_length: 15,
        plot: "test",
        release: 2
    )
end

5.times do |n|
    Novel.create!(
        user_id: 3,
        title: "test#{n + 100}",
        genre: 30,
        story_length: 25,
        plot: "test",
        release: 3
    )
end

5.times do |n|
    Review.create!(
        user_id: "#{n + 1}",
        novel_id: "#{n + 1}",
        good_point: "good#{n + 1}",
        bad_point: "bad#{n + 1}"
    )
end
