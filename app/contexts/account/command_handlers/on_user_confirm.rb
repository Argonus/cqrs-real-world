# frozen_string_literal: true

module Account
  class OnUserConfirm
    include CommandHandler

    def call(command)
      with_aggregate(User, command.aggregate_id) do |user|
        user.confirm
      end
    end
  end
end
