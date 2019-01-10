# frozen_string_literal: true

module BlogManagement
  module EventHandlers
    class OnUserConfirmed
      def call(event)
        UserReadModel.
          find(event.data[:user_id]).
          update!(confirmed: true)
      end
    end
  end
end
