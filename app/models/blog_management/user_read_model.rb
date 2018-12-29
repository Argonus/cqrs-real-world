# frozen_string_literal: true

module BlogManagement
  class UserReadModel < ApplicationRecord
    self.table_name = :blogging_users
  end
end