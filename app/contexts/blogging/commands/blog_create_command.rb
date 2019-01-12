# frozen_string_literal: true

module Blogging
  class BlogCreateCommand < Command
    attribute :blog_id, Types::Coercible::String
    attribute :user_id, Types::Coercible::String
    attribute :name, Types::Coercible::String

    alias :aggregate_id :blog_id
  end
end