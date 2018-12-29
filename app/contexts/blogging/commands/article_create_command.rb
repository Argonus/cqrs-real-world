# frozen_string_literal: true

module Blogging
  class ArticleCreatedCommand < Command
    attribute :user_id, Types::Coercible::Integer
    attribute :title, Types::Coercible::String
    attribute :content, Types::Coercible::String
  end
end