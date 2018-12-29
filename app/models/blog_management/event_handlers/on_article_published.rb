# frozen_string_literal: true

module BlogManagement
  class OnArticlePublished
    def call(event)
    end

    private

    def find_article(id)
      ArticleReadModel.find(id)
    end
  end
end
