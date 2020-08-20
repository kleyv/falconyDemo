letters_a = ('a'..'h').to_a
letters_b = ('a'..'h').to_a
numbers = (1..8)

# algo 1
# for l in letters_a do
#   for n in numbers do
#     puts "#{l} #{n}"
#   end
# end

# algo 2
# for la in letters_a do
#   for lb in lettersb do
#     puts "#{la} #{lb}"
#   end
# end

# algo 3
# for la in letters_a do
#   letters_b = letters_b.reject{ |letter|
#       letter == la
#     }
#   for lb in letters_b do
#     puts "#{la} #{lb}"
#   end
# end

# algo 3
for la in letters_a do
  letters_b = letters_a.reject{ |letter|
      letter == la
    }
  for lb in letters_b do
    puts "#{la} #{lb}"
  end
end

# do this for country_id instead of country names
countries = ['Russia', 'Germany', 'France', 'United Kingdom', 'Italy', 'Spain', 'Ukraine', 'Poland', 'Romania', 'Netherlands', 'Belgium', 'Greece', 'Portugal', 'Czech Republic', 'Hungary', 'Sweden', 'Belarus', 'Austria', 'Switzerland', 'Bulgaria', 'Serbia', 'Denmark', 'Finland', 'Slovakia', 'Norway', 'Ireland', 'Croatia', 'Bosnia and Herzegovina', 'Moldova', 'Lithuania', 'Albania', 'Macedonia', 'Slovenia', 'Latvia', 'Kosovo', 'Estonia', 'Montenegro', 'Luxembourg', 'Malta', 'Iceland', 'Jersey (UK)', 'Isle of Man (UK)', 'Andorra', 'Guernsey (UK)', 'Faroe Islands (Denmark)', 'Liechtenstein', 'Monaco', 'San Marino', 'Gibraltar (UK)', 'Aland Islands (Finland)', 'Svalbard and Jan Mayen (Norway)', 'Vatican City']


for ca in countries do
  countries = countries.reject{ |country|
      country == ca
    }
  for cb in countries do
    puts "#{ca} #{cb}"
  end

end

# Countries table
rails g model Country name

# seed algo

# Seed countries table
countries = ['Russia', 'Germany', 'France', 'United Kingdom', 'Italy', 'Spain', 'Ukraine', 'Poland', 'Romania', 'Netherlands', 'Belgium', 'Greece', 'Portugal', 'Czech Republic', 'Hungary', 'Sweden', 'Belarus', 'Austria', 'Switzerland', 'Bulgaria', 'Serbia', 'Denmark', 'Finland', 'Slovakia', 'Norway', 'Ireland', 'Croatia', 'Bosnia and Herzegovina', 'Moldova', 'Lithuania', 'Albania', 'Macedonia', 'Slovenia', 'Latvia', 'Kosovo', 'Estonia', 'Montenegro', 'Luxembourg', 'Malta', 'Iceland', 'Andorra', 'Liechtenstein', 'Monaco', 'San Marino']

for i in countries
  country = Country.create!(name: i)
end



Country.all.map do |country|
  puts country.id
end


# Travels table
rails g model travel origin:integer destination:integer open:boolean quarantine:integer test:integer country:references
# Get ids of countries in the countries table
countries_id = Country.all.map { |country| country.id }

# Generate origin and destiny pairs for travels table
# To be changed
for ca in countries_id do
  countries_id_b = countries_id.reject{ |country|
      country == ca
    }
  for cb in countries_id_b do
    puts "#{ca} #{cb}"
    Travel.create!(
      origin: ca,
      destination: cb,
      open: [true, false].sample,
      quarantine: [true, false].sample,
      test: [true, false].sample
      )
  end
end
