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
      @state = Blogging::ArticleState.new(:new)
    end

    def create(title:, content:, user_id:)
      raise AlreadyPublished if @state != new
      raise UserMissing if user_id.nil?
      raise TitleMissing if title.blank?

      apply ArticleCreatedEvent.new(data: {
        title: title,
        content: content,
        user_id: user_id
      })
    end

    def publish(user_id:)
      raise AlreadyPublished if @state == published
      raise UserMissing if user_id.nil?

      apply ArticlePublishedEvent.new()
    end

    private

    on ArticleCreatedEvent do |event|
      @state = draft
      @title = event.data[:title]
      @content = event.data[:content]
      @user_id = event.data[:user_id]
    end

    on ArticlePublishedEvent do |_|
      @state = published
    end

    private

    def new
      Blogging::ArticleState.new(:new)
    end

    def published
      Blogging::ArticleState.new(:published)
    end

    def draft
      Blogging::ArticleState.new(:draft)
    end
  end
end
