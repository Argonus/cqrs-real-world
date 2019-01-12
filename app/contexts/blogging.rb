# frozen_string_literal: true

module Blogging
end

# values
require "blogging/values/articles_state"

# events
require "blogging/events/article_created_event"
require "blogging/events/article_deleted_event"
require "blogging/events/article_published_event"
require "blogging/events/blog_created_event"
require "blogging/events/blog_published_event"

# commands
require "blogging/commands/article_create_command"
require "blogging/commands/article_delete_command"
require "blogging/commands/article_publish_command"
require "blogging/commands/blog_create_command"
require "blogging/commands/blog_publish_command"

# command handlers
require "blogging/command_handlers/on_article_create"
require "blogging/command_handlers/on_article_delete"
require "blogging/command_handlers/on_article_publish"
require "blogging/command_handlers/on_blog_create"
require "blogging/command_handlers/on_blog_publish"

# process managers
require "blogging/process_managers/publish_blog_process_manager"

# aggregates
require "blogging/article"
require "blogging/blog"
