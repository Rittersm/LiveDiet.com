# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

category = Category.create([
  { title: 'Weight Loss' },
  { title: 'Weight Gain' },
  { title: 'Muscle Mass' }
])



rating = Rating.create([
  { value: 0 },
  { value: 1 },
  { value: 2 },
  { value: 3 },
  { value: 4 },
  { value: 5 }
])

require 'wikipedia'

links = Wikipedia.find('List of diets', prop: 'links', pllimit: 'max').links.select{|x| x.downcase[-4..-1]== "diet"}

links.each do |link|
  link_page = Wikipedia.find(link)
  unless link_page.content.nil?
    Plan.create!(
      title: link,
      overview: link_page.summary,
      category: category.sample
    )
  end
end

100.times.each do
  user = User.create!(
  username: Faker::Internet.user_name(nil, %w(_-)),
  email: Faker::Internet.safe_email,
  password: "password",
  starting_weight: Faker::Number.between(120, 350),
  feet: Faker::Number.between(5, 6),
  inches: Faker::Number.between(0, 11)
  )
  subscription = Subscription.create!(
    expectations: Faker::Lorem.sentences(6).join("\n\n"),
    user: user,
    plan: Plan.offset(rand(Plan.count)).first,
    rating: rating.sample
  )
  12.times do |num|
    user.check_ins.create(
    subscription: subscription,
    weight: (user.current_weight + (user.current_weight * rand(-0.05..0.05))).round(2),
    created_at: 12.weeks.ago + ((num + 1) * 7).days
    )
  end
  42.times do |num|
    user.logs.create(
    plan: user.current_plan,
    daily_overview: Faker::Lorem.sentences(4).join("\n\n"),
    created_at: 6.weeks.ago + (num + 1).days
    )
  end
end
