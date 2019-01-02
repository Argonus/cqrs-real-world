module Blogging
  class OnArticleDeleted
    include CommandHandler

    def call(command)
      with_aggregate(Article, command.aggregate_id) do |article|
        article.delete({user_id: command.user_id})
      end
    end
  end
end
