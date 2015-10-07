require 'spec_helper'

describe ActiverecordExtensions::QueryBuilder do
  describe '#where_gt' do
    it 'should generate parameterized query' do

      LogBuffer.logs.clear

      Post.where_gt(:likes, 10).to_a

      parameterized = LogBuffer.logs.any? do |log|
        log[:sql] == 'SELECT "posts".* FROM "posts" WHERE ("posts"."likes" > ?)' &&
        log[:binds] == '[["likes", 10]]'
      end

      parameterized.should be true

    end

    it 'should throw errors for nils' do
      expect { Post.where_gt(:likes, nil).to_a }.
          to raise_error(ArgumentError, "nils are not allowed in bind parameter. please sanitize value for column: 'likes'")
    end

  end

  describe '#where_lt' do
    it 'should generate parameterized query' do

      LogBuffer.logs.clear

      Post.where_lt(:likes, 10).to_a

      parameterized = LogBuffer.logs.any? do |log|
        log[:sql] == 'SELECT "posts".* FROM "posts" WHERE ("posts"."likes" < ?)' &&
            log[:binds] == '[["likes", 10]]'
      end

      parameterized.should be true

    end
  end

  describe '#where_with_bind' do
    it 'should generate parameterized query' do

      LogBuffer.logs.clear

      clause = Post.arel_table[:title].
          eq(Arel::Nodes::BindParam.new).
          or(Post.arel_table[:likes].gt(Arel::Nodes::BindParam.new))

      Post.where_with_bind(clause, {title: 'Good Title', likes: 10}).to_a

      parameterized = LogBuffer.logs.any? do |log|
        log[:sql] == 'SELECT "posts".* FROM "posts" WHERE ("posts"."title" = ? OR "posts"."likes" > ?)' &&
        log[:binds] == '[["title", "Good Title"], ["likes", 10]]'
      end

      parameterized.should be true

    end
  end

  describe '#where_in' do
    it 'should generate parameterized query' do

      LogBuffer.logs.clear

      (1..5).each{ |value| Post.create(title: 't' + value.to_s, likes: value ) }

      actual = Post.where_in(:likes, [2,3,4]).pluck(:title).to_a

      parameterized = LogBuffer.logs.any? do |log|
        log[:sql] == 'SELECT "posts"."title" FROM "posts" WHERE "posts"."likes" IN (?, ?, ?)' &&
            log[:binds] == '[["likes", 2], ["likes", 3], ["likes", 4]]'
      end

      parameterized.should be true

      expect(actual).to match_array(%w(t2 t3 t4))

    end
  end
end
