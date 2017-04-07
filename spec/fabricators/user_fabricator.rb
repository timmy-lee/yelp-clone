Fabricator(:user) do
  full_name { Faker::Name.name }
  password 'anything'
  username { Faker::Lorem.word }
end
