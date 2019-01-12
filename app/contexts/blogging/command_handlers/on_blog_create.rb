module Blogging
  class OnBlogCreate
    include CommandHandler

    def call(command)
      with_aggregate(Blog, command.aggregate_id) do |blog|
        blog.create(
          {
            name: command.name,
            user_id: command.user_id
          }
        )
      end
    end
  end
end