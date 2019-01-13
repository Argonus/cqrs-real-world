#frozen_string_literal: true

module Blogging
  class PublishBlogProcessManager
    class State
      def initialize
        @blog_created = false
        @article_published = false
        @blog_published = false

        @version = -1
        @event_ids_to_link = []
      end

      def apply(*events)
        events.each do |event|
          case event
          when ::Blogging::BlogCreatedEvent then apply_blog_created
          when ::Blogging::ArticlePublishedEvent then apply_article_published
          when ::Blogging::BlogPublishedEvent then apply_blog_published
          end
          @event_ids_to_link << event.event_id
        end
      end

      def load(stream_name, event_store:)
        events = event_store.read.stream(stream_name).forward.to_a
        events.each do |event|
          apply(event)
        end

        @version = events.size - 1
        @event_ids_to_link = []

        self
      end

      def store(stream_name, event_store:)
        event_store.link(
          @event_ids_to_link,
          stream_name: stream_name,
          expected_version: @version
        )
        @version += @event_ids_to_link.size
        @event_ids_to_link = []
      end

      def publishable?
        !@blog_published && @blog_created && @article_published
      end

      private

      def apply_blog_created
        @blog_created = true
      end

      def apply_article_published
        @article_published = true
      end

      def apply_blog_published
        @blog_published = true
      end
    end
    private_constant :State

    def initialize(command_bus: Rails.configuration.command_bus, event_store: Rails.configuration.event_store)
      @command_bus = command_bus
      @event_store = event_store
    end

    def call(event)
      blog_id = event.data[:blog_id]
      stream_name = "BloggingBlog$#{blog_id}"

      state = State.new
      state.load(stream_name, event_store: @event_store)
      state.apply(event)
      state.store(stream_name, event_store: @event_store)

      @command_bus.call(BlogPublishCommand.new({
        blog_id: blog_id
      })) if state.publishable?
    end
  end
end
