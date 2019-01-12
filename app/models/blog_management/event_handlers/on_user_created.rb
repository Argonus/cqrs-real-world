# frozen_string_literal: true

module BlogManagement
  module EventHandlers
    class OnUserCreated
      def call(event)
        UserReadModel.create!(
          id: event.data[:user_id],
          name: name(event.data),
        )
      end

      private

      def name(data)
        "#{data[:first_name]} #{data[:last_name]}"
      end
    end
  end
end
