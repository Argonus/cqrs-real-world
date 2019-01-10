# frozen_string_literal: true

module Account
end

# values

# events
require "account/events/user_confirmed_event"
require "account/events/user_created_event"

# commands
require "account/commands/user_confirm_command"
require "account/commands/user_create_command"

# command handlers
require "account/command_handlers/on_user_confirm"
require "account/command_handlers/on_user_create"

# aggregates
require "account/user"
