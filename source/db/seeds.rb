# db/seeds.rb

EventParticipant.destroy_all
Event.destroy_all
User.destroy_all

users = []
5.times do |i|
  users << User.create!(
    first_name: "User#{i + 1}",
    last_name: "Test#{i + 1}",
    email: "user#{i + 1}@example.com"
  )
end

events = []
3.times do |i|
  events << Event.create!(
    name: "Event#{i + 1}",
    organiser: users.first,
    start: Time.now + (i + 1).days,
    end: Time.now + (i + 1).days + 2.hours,
    participants_limit: rand(5..10)
  )
end

events.each do |event|
  EventParticipant.create!(
      user: users.first,
      event: event
  )
  EventParticipant.create!(
      user: users.second,
      event: event
  )
end

puts "Successfully seeded!"
