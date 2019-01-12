module Blogging
  class BlogPublishCommand < Command
    attribute :blog_id, Types::Coercible::String

    alias :aggregate_id :blog_id
  end
end
