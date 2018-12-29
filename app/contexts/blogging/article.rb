# frozen_string_literal: true

require "aggregate_root"

module Blogging
  class Article
    include AggregateRoot

    raise AlreadyPublished = Class.new(StandardError)
    raise UserMissing = Class.new(StandardError)

    def initialize(id)
      @id = id
      @state = Blogging::ArticleState.new(:draft)
    end

    def publish(title:, content:, user_id:)
      raise AlreadyPublished if @state == published
      raise UserMissing if user_id.nil?

      apply ArticlePublishedEvent.new(data: {
        title: title,
        content: content,
        id: @id
      })
    end

    private

    on ArticlePublishedEvent do |event|
      @user_id = event.data[:user_id]
      @state = published
    end

    private

    def published
      Blogging::ArticleState.new(:published)
    end
  end
end
