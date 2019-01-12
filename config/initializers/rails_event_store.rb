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
    # blog management
    store.subscribe(BlogManagement::EventHandlers::OnArticleCreated.new, to: [Blogging::ArticleCreatedEvent])
    store.subscribe(BlogManagement::EventHandlers::OnArticleDeleted.new, to: [Blogging::ArticleDeletedEvent])
    store.subscribe(BlogManagement::EventHandlers::OnArticlePublished.new, to: [Blogging::ArticlePublishedEvent])

    store.subscribe(BlogManagement::EventHandlers::OnUserCreated.new, to: [Account::UserCreatedEvent])
    store.subscribe(BlogManagement::EventHandlers::OnUserConfirmed.new, to: [Account::UserConfirmedEvent])

    store.subscribe(BlogManagement::EventHandlers::OnBlogCreated.new, to: [Blogging::BlogCreatedEvent])
    store.subscribe(BlogManagement::EventHandlers::OnBlogPublished.new, to: [Blogging::BlogPublishedEvent])

    # account management
    store.subscribe(AccountManagement::EventHandlers::OnUserCreated.new, to: [Account::UserCreatedEvent])
    store.subscribe(AccountManagement::EventHandlers::OnUserConfirmed.new, to: [Account::UserConfirmedEvent])
  end

  # Register command handlers below
  Rails.configuration.command_bus.tap do |bus|
    bus.register(Blogging::ArticleCreateCommand, Blogging::OnArticleCreate.new)
    bus.register(Blogging::ArticleDeleteCommand, Blogging::OnArticleDelete.new)
    bus.register(Blogging::ArticlePublishCommand, Blogging::OnArticlePublish.new)

    bus.register(Blogging::BlogCreateCommand, Blogging::OnBlogCreate.new)
    bus.register(Blogging::BlogPublishCommand, Blogging::OnBlogPublish.new)

    bus.register(Account::UserConfirmCommand, Account::OnUserConfirm.new)
    bus.register(Account::UserCreateCommand, Account::OnUserCreate.new)
  end
end
