# frozen_string_literal: true

module BlogManagement
  module EventHandlers
    class OnArticleCreated
      def call(event)
        ArticleReadModel.create!(
          id: event.data[:article_id],
          title: event.data[:title],
          content: event.data[:content],
          user_id: event.data[:user_id],
          created_at: event.data[:timestamp],
          updated_at: event.data[:timestamp]
        )
      end
    end
  end
end
