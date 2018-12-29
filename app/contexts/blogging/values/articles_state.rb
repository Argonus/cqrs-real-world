# frozen_string_literal: true

module Blogging
  class ArticleState
    InvalidState = Class.new(StandardError)
    VALID_STATES = %i[new draft published hidden].freeze

    attr_reader :state

    def initialize(state)
      raise InvalidState unless state.in?(VALID_STATES)
      @state = state
      freeze
    end

    def ==(state)
      @state == state.state
    end
  end
end
