# frozen_string_literal: true

module AccountManagement
  module EventHandlers
    class OnUserConfirmed
      def call(event)
        UserReadModel.
          find(event.data[:user_id]).
          update!(confirmed_at: event.data[:timestamp])
      end
    end
  end
end
