# frozen_string_literal: true

module Account
  class UserCreateCommand < Command
    attribute :user_id, Types::Coercible::String
    attribute :first_name, Types::Coercible::String
    attribute :last_name, Types::Coercible::String

    alias :aggregate_id :user_id
  end
end
