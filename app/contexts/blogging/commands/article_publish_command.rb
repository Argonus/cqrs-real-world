module Blogging
  class ArticlePublishCommand < Command
    attribute :article_id, Types::Coercible::String
    attribute :user_id, Types::Coercible::String
    attribute :blog_id, Types::Coercible::String

    alias :aggregate_id :article_id
  end
end
