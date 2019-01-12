# frozen_string_literal: true

module Account
  class OnUserCreate
    include CommandHandler

    def call(command)
      with_aggregate(User, command.aggregate_id) do |user|
        user.create(
          first_name: command.first_name,
          last_name: command.last_name
        )
      end
    end
  end
end
