# AnyLinks

AnyLinks is a ActiveRecord extension which enables simple linking any model to any other model, using a single line decleration and a single table.

It is a simple-to-use extension to the polymorphic schema, but without the complexity of the polymorphic schema, and with much more capabilities.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_record-any_links'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_record-any_links

## Getting Started

### 1. Creating any_links table

AnyLinks requires an any_links table to store the links.
You can create the table by add the following migration, and running:

```ruby
 rake db:migrate
```

```ruby
 class CreateAnyLinks < ActiveRecord::Migration
   def up
     create_table :any_links do |t|
       t.integer :id1, null: false
       t.string :type1, null: false
       t.integer :id2, null: false
       t.string :type2, null: false

       t.timestamps
     end

     change_table :any_links do |t|
       t.index [:id1, :type1, :id2, :type2], unique: true
       t.index [:id1, :type1, :type2]
       t.index [:id2, :type2, :type1]
     end
   end

   def down
     drop_table :any_links
   end
 end
```

### 2. Linking models

In this example we link the Reader model to Books model, with many to many relationship.

```ruby
class Reader < ActiveRecord::Base
  has_many_to_many :books
end

class Book < ActiveRecord::Base
  has_many_to_many :readers
end
```
### 3. Using the linked models

Use the linked models the same way you use any has_many relationships.
examples:

```ruby
@reader.books = [book1, book2]
@reader.books.where(...)
ids = @readers.book_ids
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Hagai-Arzi/active_record-any_links.

