class Post < ActiveRecord::Base
  extend ActiverecordExtensions::QueryBuilder
  has_many :comments
  has_many :favorites
end

class Comment < ActiveRecord::Base
  include ActiverecordExtensions::QueryBuilder
  belongs_to :post
  belongs_to :author
end

class Author < ActiveRecord::Base
  include ActiverecordExtensions::QueryBuilder
  has_one :comment
  has_and_belongs_to_many :collab_posts
end

class Favorite < ActiveRecord::Base
  include ActiverecordExtensions::QueryBuilder
  belongs_to :post
end

class CollabPost < ActiveRecord::Base
  include ActiverecordExtensions::QueryBuilder
  has_and_belongs_to_many :authors
end
