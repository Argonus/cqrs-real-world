# frozen_string_literal: true
require "rails_event_store"
require "aggregate_root"
require "arkency/command_bus"
require "blogging"

Rails.configuration.to_prepare do
  Rails.configuration.event_store = RailsEventStore::Client.new
  Rails.configuration.command_bus = Arkency::CommandBus.new

  AggregateRoot.configure do |config|
    config.default_event_store = Rails.configuration.event_store
  end

  # Subscribe event handlers below
  Rails.configuration.event_store.tap do |store|
    store.subscribe(BlogManagement::EventHandlers::OnArticleCreated.new, to: [Blogging::ArticleCreatedEvent])
    store.subscribe(BlogManagement::EventHandlers::OnArticleDeleted.new, to: [Blogging::ArticleDeletedEvent])
    store.subscribe(BlogManagement::EventHandlers::OnArticlePublished.new, to: [Blogging::ArticlePublishedEvent])
  end

  # Register command handlers below
  Rails.configuration.command_bus.tap do |bus|
    bus.register(Blogging::ArticleCreateCommand, Blogging::OnArticleCreate.new)
    bus.register(Blogging::ArticleDeleteCommand, Blogging::OnArticleDelete.new)
    bus.register(Blogging::ArticlePublishCommand, Blogging::OnArticlePublish.new)
  end
end
