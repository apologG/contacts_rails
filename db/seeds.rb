Group.destroy_all
Contact.destroy_all

groups_ids = []
groups_ids << Group.create(name: 'Клиенты').id
groups_ids << Group.create(name: 'Друзья').id
groups_ids << Group.create(name: 'Семья').id
20.times do |i|
    Contact.create(
          name: Faker::Name.name, 
          company: Faker::Company.name, 
          email: Faker::Internet.email, 
          phone: Faker::PhoneNumber.cell_phone, 
          address: "#{Faker::Address.street_address} #{Faker::Address.zip} #{Faker::Address.city}",
          group_id: groups_ids.sample
                                 )
end
