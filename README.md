# AnyLinks

AnyLinks is an ActiveRecord extension which enables simple linking any model to any other model, using a single line statement and a single table.

It is a simple-to-use extension to the polymorphic schema, but without the complexity and with much more capabilities.

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

### 1. Create any_links table

AnyLinks requires an any_links table to store the links.
You can create the table by adding the following migration, and running:

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

In the following example we link the User model to Group model, using many to many relationship.

```ruby
class User < ActiveRecord::Base
  has_many_to_many :groups
end

class Group < ActiveRecord::Base
  has_many_to_many :users
end
```
### 3. Using the linked models

Use the linked models the same way you use any has_many relationship.
examples:

```ruby
@user.groups = [group, group]
@group.user_ids # => [4,7,9]
@group.users.exists?
@group.users.where(first_name: "James")
```

## AnyLinks statements

There are three statements added to ActiveRecord:

```ruby
has_many_to_many
has_many_to_one
has_one_to_many
```

Each one of them creates a bundle of helper methods.

## has_many_to_many

has_many_to_many Specifies a many-to-many bi-directional association.
Regularly, has_many_to_many is declared in each side of the association models.
It will also work if declared only on one side of the association. However, doing so will
not generate the dynamic methods on the other side, making the connections seen from
one side only

has_many_to_many can be used even on the same model:

```ruby
class User < ActiveRecord::Base
  has_many_to_many :friends, class_name: User
end
```

The previous link is also bidirectional!
The associations, for all types and collections, are stored together in a single table called 'any_links'.
The table contain all links between all instances of any type.
Every record represent a link, which contains id and type for each side of the connection,
which are called id1, type1, and id2, type2 respectively.
Since the links are bi-directional, theoretically, any object can be represented as the left
side link (#1) or right side (#2).
For simplicity and performance, the links are stored thus the "smallest" type is in the left.
Any link betwwen 'Incident' and 'Change' is stored as the Change object in the left, since
the string types are 'Change' < 'Incident'.
This technique is 'Hidden' and transparent for the has_many_to_many consumer.

For association of the same type - (e.g. `Incident has_many incidents`):
do standard declaration in the Class (i.e. has_many_to_many <collection>).
In that case, a callbacks of after create and after destroy shall be called in the relevant any_link class.
To overcome association methods that skip callbacks (as clear method) we override the delete_all
association method of has many by passing a block with the new function.
Notice that calling with 'dependent' param in this case shall raise an error since it doesn't have a meaning
for once and secondly this param cannot be passed to destroy_all which is the callback that we call.

A set dynamic methods are generated for altering the set of linked objects.
They are the same methods as added by has_many decleration.
The following methods for retrieval and query of
collections of associated objects will be added:

#### Auto-generated methods

```ruby
        others
        others=(other,other,...)
        other_ids
        other_ids=(id,id,...)
        others<<
        others.push
        others.concat
        others.build(attributes={})
        others.create(attributes={})
        others.create!(attributes={})
        others.size
        others.length
        others.count
        others.sum(args*,&block)
        others.empty?
        others.clear
        others.delete(other,other,...)
        others.delete_all
        others.destroy_all
        others.find(*args)
        others.exists?
        others.uniq
        others.reset
 ```
#### Options

      [:class_name]
        Specify the class name of the association. Use it only if that name can't be inferred
        from the association name. So <tt>has_many_to_many :products</tt> will by default be linked
        to the Product class, but if the real class name is SpecialProduct, you'll have to
        specify it with this option.

#### Examples

```ruby
      has_many_to_many :authors                             # linked class is Author
      has_many_to_many :authors, class_name: "Person"       # specify that linked class is Person
```

## Development


After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Hagai-Arzi/active_record-any_links.

