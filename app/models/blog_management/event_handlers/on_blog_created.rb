# frozen_string_literal: true

module BlogManagement
  module EventHandlers
    class OnBlogCreated
      def call(event)
        BlogReadModel.create!(
          id: event.data[:blog_id],
          name: event.data[:name],
          user_id: event.data[:user_id],

          created_at: event.data[:timestamp],
          updated_at: event.data[:timestamp]
        )
      end
    end
  end
end
