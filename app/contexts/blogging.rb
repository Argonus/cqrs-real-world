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
require "blogging/commands/article_published_command"

# command handlers
require "blogging/command_handlers/on_article_created"
require "blogging/command_handlers/on_article_deleted"
require "blogging/command_handlers/on_article_published"

# aggregates
require "blogging/article"
