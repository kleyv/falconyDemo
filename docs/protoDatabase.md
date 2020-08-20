## Countries table
### Migration
```zsh
rails g model Country name
```
```rb
class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :name, null => false
      t.string :risk, null => false

      t.timestamps
    end
  end
end
```
### Seed
```rb
countries = ['Russia', 'Germany', 'France', 'United Kingdom', 'Italy', 'Spain', 'Ukraine', 'Poland', 'Romania', 'Netherlands', 'Belgium', 'Greece', 'Portugal', 'Czech Republic', 'Hungary', 'Sweden', 'Belarus', 'Austria', 'Switzerland', 'Bulgaria', 'Serbia', 'Denmark', 'Finland', 'Slovakia', 'Norway', 'Ireland', 'Croatia', 'Bosnia and Herzegovina', 'Moldova', 'Lithuania', 'Albania', 'Macedonia', 'Slovenia', 'Latvia', 'Kosovo', 'Estonia', 'Montenegro', 'Luxembourg', 'Malta', 'Iceland', 'Andorra', 'Liechtenstein', 'Monaco', 'San Marino']

for i in countries
  country = Country.create!(name: i)
end
```
### Model validation
```rb
class Country < ApplicationRecord
  belongs_to :travel
  belongs_to :case
  has_many :users

  validates :name, presence: true
end

```

| id | name | risk |
|---|---|---|
| 1 | France | Yellow |
| 2 | Germany | Green |
| 3 | Italy | Red |

## Travels table
### Migration
```rb
class CreateTravels < ActiveRecord::Migration[6.0]
  def change
    create_table :travels do |t|
      t.integer :origin, null => false
      t.integer :destination, null => false
      t.integer :open # empty means we have no data
      t.integer :quarantine # empty means we have no data
      t.integer :test # empty means we have no data

      t.timestamps
    end
  end
end
```
### Seed
```rb
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
```
### Model validation
```rb
class Travel < ApplicationRecord
  has_many :countries
  belongs_to :bookmark

  validates :origin, :destination, presence: true
end

```
| id  | origin_id  |  destination_id | open  | quarantine  | test  |
|---|---|---|---|---|---|
|  1 | 2  | 1  | 0  | 0  | 0  |
| 2  | 1  |  2 |  1 |  14 | 14  |
| 3  | 3  | 1  | 1  | 7  | 14  |

**To consider:**
- for column **open** 0 means closed and 1 means open
- for column **quarantine** 0 means no quarantine is necessary and any number above it is equal to the the numbers required to stay in quarantine
- for column **test** 0 means no negative days required and any number above it is equal to the the number of days since the test
- if destination_id is closed, the country doesn't require quarantine or tests. In this case it should only be displayed to the user that the destination is closed.

## Cases table
### Migration
This table would allow us to calculate change in numbers: last 2 weeks, last 2 months, since the beginning. These 3 graphs alone should give a great picture.
```rb
class CreateCases < ActiveRecord::Migration[6.0]
  def change
    create_table :cases do |t|
      t.integer :country_id, null => false
      t.integer :week, null => false # needs to be updated periodically
      t.integer :dead # empty means we have no data
      t.integer :infected # empty means we have no data
      t.integer :morbidity # percentage of those infeced with COVID that died due to it - empty means we have no data
      t.integer :mortality # percentage of total population that died with COVID - empty means we have no data

      t.timestamps
    end
  end
end
```
### Model validation
```rb
class Case < ApplicationRecord
  belongs_to :travel
  has_many :countries

  validates :country_id, week: true
end

```

## Users table
### Migration
```rb
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null => false
      t.string :email # validate email
      t.string :nationality # empty means we have no data

      t.timestamps
    end
  end
end
```
### Model validation
```rb
class User < ApplicationRecord
  has_many :bookmarks
  belongs_to :country

  validates :name, :email presence: true # Users shouldn't be obligated do declare nationality
end

```
## Bookmarks table
### Migration
```rb
class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.string :travel_id, null => false

      t.timestamps
  end
end
```
### Model validation
```rb
class Review < ApplicationRecord
  belongs_to :user
  has_many :travels

  validates :travel_id, presence: true
end

```
