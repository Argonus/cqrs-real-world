# frozen_string_literal: true

module Blogging
  class OnBlogPublish
    include CommandHandler

    def call(command)
      with_aggregate(Blog, command.aggregate_id) do |blog|
        blog.publish(
          {
            user_id: command.user_id
          }
        )
      end
    end
  end
end
