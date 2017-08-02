Fabricator(:business) do
  Faker::Config.random = Random.new(76)
  name { Faker::Lorem.words(3).join(' ') }
  street { Faker::Address.street_address }
  phone { Faker::Number.number(10) }
  city { Faker::Address.city }
  state { Faker::Address.state }
  zipcode { Faker::Address.zip }
end
