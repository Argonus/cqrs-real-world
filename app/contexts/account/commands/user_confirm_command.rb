# frozen_string_literal: true

module Account
  class UserConfirmCommand < Command
    attribute :user_id, Types::Coercible::String

    alias :aggregate_id :user_id
  end
end
