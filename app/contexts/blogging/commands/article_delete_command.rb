# frozen_string_literal: true

module Blogging
  class ArticleDeleteCommand < Command
    attribute :article_id, Types::Coercible::String
    attribute :user_id, Types::Coercible::String

    alias :aggregate_id :article_id
  end
end
