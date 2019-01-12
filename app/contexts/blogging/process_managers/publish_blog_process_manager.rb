#frozen_string_literal: true

module Blogging
  class PublishBlogProcessManager

    class State
      def initialize
        @blog_created = false
        @user_confirmed = false
        @article_published = false

        @version = -1
        @event_ids_to_link = []
      end

      def apply_blog_created
        @blog_created = true
      end
      def apply_user_confirmed
        @user_confirmed = true
      end
      def apply_article_published
        @article_published = true
      end

      def apply(*events)
        events.each do |event|
          case event
          when nil then apply_blog_created
          when nil then apply_article_published
          when nil then apply_user_confirmed
          end

          @event_ids_to_link << event.id
        end
      end

      def load(stream_name, event_store:)
        events = event_store.read_stream_events_forward(stream_name)
        events.each do |event|
          apply(event)
        end

        @version = events.size - 1
        @event_ids_to_link = []

        self
      end

      def store(stream_name, event_store:)
        event_store.link_to_stream(
          @event_ids_to_link,
          stream_name: stream_name,
          expected_version: @version
        )
        @version += @event_ids_to_link.size
        @event_ids_to_link = []
      end
    end
    private_constant :State

    def initialize(command_bus:, event_store:)
      @command_bus = command_bus
      @event_store = event_store
    end

    def call(event)
      order_id = event.data(:order_id)
      stream_name = "CateringMatch$#{order_id}"

      state = State.new
      state.load(stream_name, event_store: @event_store)
      state.apply(event)
      state.store(stream_name, event_store: @event_store)

      command_bus.(PublishBlogCommand.new(data: {
        order_id: order_id
      })) if state.complete?
    end
  end
end
