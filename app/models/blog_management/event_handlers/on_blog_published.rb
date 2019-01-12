# frozen_string_literal: true

module BlogManagement
  module EventHandlers
    class OnBlogPublished
      def call(event)
        UserReadModel.
          find(event.data[:user_id]).
          update!(published: true)
      end
    end
  end
end
