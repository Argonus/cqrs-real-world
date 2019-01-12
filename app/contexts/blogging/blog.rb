# frozen_string_literal: true

require "aggregate_root"

module Blogging
  class Blog
    include AggregateRoot

    UserMissing = Class.new(StandardError)
    NameMissing = Class.new(StandardError)

    def initialize(id)
      @id = id
    end

    def create(user_id:, name:)
      raise UserMissing if user_id.nil?
      raise NameMissing if name.blank?

      apply ::Blogging::BlogCreatedEvent.new(data: {
        blog_id: @id,
        user_id: user_id,
        name: name,

        timestamp: DateTime.current
      })
    end

    def publish(user_id:)
      raise UserMissing if user_id.nil?

      apply ::Blogging::BlogPublishedEvent.new(data: {
        blog_id: @id,

        timestamp: DateTime.current
      })
    end

    private

    on ::Blogging::BlogCreatedEvent do |event|
      @id = event.data[:blog_id]
      @name = event.data[:name]
      @user_id = event.data[:user_id]
    end

    on ::Blogging::BlogPublishedEvent do |event|
      @id = event.data[:article_id]
    end
  end
end
