# frozen_string_literal: true

module Blogging
  class OnBlogPublish
    include CommandHandler

    def call(command)
      with_aggregate(Blog, command.aggregate_id) do |blog|
        blog.publish
      end
    end
  end
end
