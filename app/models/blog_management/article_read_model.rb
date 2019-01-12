# frozen_string_literal: true

module BlogManagement
  class ArticleReadModel < ApplicationRecord
    self.table_name = :blogging_articles
    enum state: %i[draft published hidden]

    belongs_to :user, class_name: "BlogManagement::UserReadModel", foreign_key: :user_id
  end
end
