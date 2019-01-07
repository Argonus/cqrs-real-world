# frozen_string_literal: true

module Blogging
  class ArticleCreateCommand < Command
    attribute :article_id, Types::Coercible::String
    attribute :user_id, Types::Coercible::String
    attribute :title, Types::Coercible::String
    attribute :content, Types::Coercible::String

    alias :aggregate_id :article_id
  end
end