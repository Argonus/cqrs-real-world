module Blogging
  class ArticlePublishedCommand < Command
    attribute :article_id, Types::Coercible::Integer
    attribute :user_id, Types::Coercible::Integer

    alias :aggregate_id :article_id
  end
end
