# frozen_string_literal: true

module Blogging
  class OnArticlePublish
    include CommandHandler

    def call(command)
      with_aggregate(Article, command.aggregate_id) do |article|
        article.publish(
          {
            user_id: command.user_id
          }
        )
      end
    end
  end
end
