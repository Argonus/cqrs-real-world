module Blogging
  class OnArticleCreate
    include CommandHandler

    def call(command)
      with_aggregate(Article, command.aggregate_id) do |article|
        article.create(
          {
            title: command.title,
            content: command.content,
            user_id: command.user_id
          }
        )
      end
    end
  end
end