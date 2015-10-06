require 'spec_helper'

describe ActiverecordExtensions::QueryBuilder do

  it 'should be able to where_gt' do

    LogBuffer.logs.clear

    Post.where_gt(:likes, 10).to_a

    parameterized = LogBuffer.logs.any? do |log|
      log[:sql] == 'SELECT "posts".* FROM "posts" WHERE ("posts"."likes" > ?)' &&
      log[:binds] == '[["likes", 10]]'
    end

    parameterized.should be true

  end
end
