## Countries table
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

| id | name | risk |
|---|---|---|
| 1 | France | Yellow |
| 2 | Germany | Green |
| 3 | Italy | Red |

## Travels table
```rb
class CreateTravels < ActiveRecord::Migration[6.0]
  def change
    create_table :travels do |t|
      t.integer :origin_id, null => false
      t.integer :destination_id, null => false
      t.integer :open # empty means we have no data
      t.integer :quarantine # empty means we have no data
      t.integer :test # empty means we have no data

      t.timestamps
    end
  end
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
This table would allow us to calculate change in numbers: last 2 weeks, last 2 months, since the beginning. These 3 graphs alone should give a great picture.
```rb
class CreateCases < ActiveRecord::Migration[6.0]
  def change
    create_table :cases do |t|
      t.integer :country_id, null => false
      t.integer :week # empty means we have no data
      t.integer :dead # empty means we have no data
      t.integer :infected # empty means we have no data

      t.timestamps
    end
  end
end
```

## Users table
```rb
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
  end
end
```
## Bookmarks table
```rb
class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
  end
end
```
