# frozen_string_literal: true

module BlogManagement
  module EventHandlers
    class OnArticlePublished
      def call(event)
      end

      private

      def find_article(id)
        ArticleReadModel.find(id)
      end
    end
  end
end
