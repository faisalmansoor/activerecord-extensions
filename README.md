## activerecord-extensions

Misc activerecord extensions

## Installation

`gem install activerecord-extensions`

## Usage

```ruby
require 'activerecord-extensions'
```

### QueryBuilder

Helps parameterize queries

Activerecord generates parameterized queries when hash conditions are used with #where.
But, it generates non parameterized queries when string conditions are used with string queries.

E.g.

```ruby
Post.where(id: 1)
# generates
# SELECT "posts".* FROM "posts" WHERE "posts"."id" = ?  [["id", 1]]
```

But

```ruby
Post.where('id = ?', 1)
# generates
# SELECT [posts].* FROM [posts] WHERE (id = 1)
```

ActiveRecord can only generate parameterized queries for `eq` conditions with `and` operator, queries involving `<`, `>`
and other operators are non parameterized by ActiveRecord.

QueryBuilder helps you easily parameterize `<`, `>`, `in` and raw arel conditions.

```ruby
Post.where_gt(:likes, 10).to_a
# will generate
# SELECT "posts".* FROM "posts" WHERE ("posts"."likes" > ?)
# [["likes", 10]]
```

```ruby
Post.where_lt(:likes, 10).to_a
# will generate
# SELECT "posts".* FROM "posts" WHERE ("posts"."likes" < ?)
# [["likes", 10]]
```

```ruby
Post.where_in(:likes, [2,3,4]).pluck(:title).to_a
# will generate
# SELECT "posts"."title" FROM "posts" WHERE "posts"."likes" IN (?, ?, ?)
# [["likes", 2], ["likes", 3], ["likes", 4]]
```

```ruby
clause = Post.arel_table[:title].
  eq(Arel::Nodes::BindParam.new).
  or(Post.arel_table[:likes].gt(Arel::Nodes::BindParam.new))

Post.where_with_bind(clause, {title: 'Good Title', likes: 10}).to_a

# will generate
# SELECT "posts".* FROM "posts" WHERE ("posts"."title" = ? OR "posts"."likes" > ?)
# [["title", "Good Title"], ["likes", 10]]
```

## Requirements

Requires ActiveRecord = 4.2.4, tested with Ruby 2.2.0.

## Running Tests

`bundle exec rspec`

## Authors

* Faisal Mansoor http://github.com/faisalmansoor
