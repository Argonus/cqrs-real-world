# frozen_string_literal: true

module Blogging
end

# values
require "blogging/values/articles_state"

# events
require "blogging/events/article_created_event"
require "blogging/events/article_deleted_event"
require "blogging/events/article_published_event"

# commands
require "blogging/commands/article_create_command"
require "blogging/commands/article_delete_command"
require "blogging/commands/article_publish_command"

# command handlers
require "blogging/command_handlers/on_article_create"
require "blogging/command_handlers/on_article_delete"
require "blogging/command_handlers/on_article_publish"

# aggregates
require "blogging/article"
