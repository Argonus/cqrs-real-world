# frozen_string_literal: true

require "aggregate_root"

module Blogging
  class Article
    include AggregateRoot

    AlreadyPublished = Class.new(StandardError)
    UserMissing = Class.new(StandardError)
    TitleMissing = Class.new(StandardError)

    def initialize(id)
      @id = id
      @state = ::Blogging::ArticleState.new(:new)
    end

    def create(title:, content:, user_id:)
      raise AlreadyPublished if @state != new
      raise UserMissing if user_id.nil?
      raise TitleMissing if title.blank?

      apply ::Blogging::ArticleCreatedEvent.new(data: {
        article_id: @id,
        title: title,
        content: content,
        user_id: user_id,
        created_at: DateTime.current
      })
    end

    def publish(user_id:)
      raise AlreadyPublished if @state == published
      raise UserMissing if user_id.nil?

      apply ::Blogging::ArticlePublishedEvent.new({article_id: @id})
    end

    private

    on ::Blogging::ArticleCreatedEvent do |event|
      @state = draft
      @id = event.data[:article_id]
      @title = event.data[:title]
      @content = event.data[:content]
      @user_id = event.data[:user_id]
    end

    on ::Blogging::ArticlePublishedEvent do |event|
      @id = event.data[:article_id]
      @state = published
    end

    def new
      ::Blogging::ArticleState.new(:new)
    end

    def published
      ::Blogging::ArticleState.new(:published)
    end

    def draft
      ::Blogging::ArticleState.new(:draft)
    end
  end
end
