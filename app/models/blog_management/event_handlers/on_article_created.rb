# frozen_string_literal: true

module BlogManagement
  module EventHandlers
    class OnArticleCreated
      def call(event)
        ArticleReadModel.create!(
          id: event.data[:id],
          title: event.data[:title],
          content: event.data[:content],
          user_id: event.data[:user_id]
        )
      end
    end
  end
end
