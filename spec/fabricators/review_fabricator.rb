Fabricator(:review) do
  content { Faker::Lorem.paragraph }
  rating { (1..5).to_a.sample }
end
