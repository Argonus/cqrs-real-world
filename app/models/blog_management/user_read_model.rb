# frozen_string_literal: true

module BlogManagement
  class UserReadModel < ApplicationRecord
    self.table_name = :blogging_users

    has_many :articles, class_name: "BlogManagement::ArticleReadModel", foreign_key: :user_id
  end
end