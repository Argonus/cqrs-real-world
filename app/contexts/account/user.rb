# frozen_string_literal: true

require "aggregate_root"

module Account
  class User
    include AggregateRoot

    FirstNameMissing = Class.new(StandardError)
    UserMissing = Class.new(StandardError)

    def initialize(id)
      raise UserMissing if id.nil?
      @id = id
    end

    def create(first_name:, last_name:)
      raise FirstNameMissing if first_name.blank?

      apply ::Account::UserCreatedEvent.new(data: {
        user_id: @id,
        first_name: first_name,
        last_name: last_name,
        timestamp: DateTime.current
      })
    end

    def confirm
      apply ::Account::UserConfirmedEvent.new(data: {
        user_id: @id,
        timestamp: DateTime.current
      })
    end

    private

    on ::Account::UserConfirmedEvent do |event|
      @id = event.data[:user_id]
    end

    on ::Account::UserCreatedEvent do |event|
      @first_name = event.data[:first_name]
      @last_name = event.data[:last_name]
    end
  end
end
