# frozen_string_literal: true

module BlogManagement
  module EventHandlers
    class OnBlogPublished
      def call(event)
        BlogReadModel.
          find(event.data[:blog_id]).
          update!(published: true)
      end
    end
  end
end
