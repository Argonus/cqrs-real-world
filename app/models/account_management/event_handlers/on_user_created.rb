# frozen_string_literal: true

module AccountManagement
  module EventHandlers
    class OnUserCreated
      def call(event)
        UserReadModel.create!(
          id: event.data[:user_id],
          first_name: event.data[:first_name],
          last_name: event.data[:last_name],
          created_at: event.data[:timestamp],
          updated_at: event.data[:timestamp]
        )
      end
    end
  end
end
