# frozen_string_literal: true

require "aggregate_root"

module Blogging
  class Blog
    include AggregateRoot

    def initialize(user)
      @user = user
    end
  end
end