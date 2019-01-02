# frozen_string_literal: true

module BlogManagement
  module EventHandlers
    class OnArticleDeleted
      def call(event)
        ArticleReadModel.find_by(id: event.data[:article_id], user_id: event.data[:user_id]).delete
      end
    end
  end
end
