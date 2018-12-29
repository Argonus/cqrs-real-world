module Blogging
  class ArticlePublishedCommand < Command
    attribute :id, Types::Coercible::Integer
    attribute :user_id, Types::Coercible::Integer
    attribute :title

    alias :aggregate_id :id
  end
end
