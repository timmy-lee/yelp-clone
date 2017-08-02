Fabricator(:user) do
  Faker::Config.random = Random.new(44)
  full_name { Faker::Name.name }
  password 'anything'
  username { Faker::Lorem.word }
end
