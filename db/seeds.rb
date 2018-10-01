# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Task.destroy_all
User.destroy_all

5.times do |i|
  User.create(name: "user#{i+1}", password: 'password')
end

User.all.each do |user|
  user.tasks.create(description: "#{user.name}'s task", is_complete: [true, false].sample)
end

Task.all.each do |task|
  (1..5).to_a.sample.times do |i|
    task.comments.create(content: "comment ##{i+1}", user_id: User.all.sample.id)
  end
end