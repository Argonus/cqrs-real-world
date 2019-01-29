# frozen_string_literal: true
require "rails_helper"

RSpec.describe Account::OnUserCreate do
  it "confirms user" do
    id = SecureRandom.uuid
    event_store = RailsEventStore::Client.new
    command = Account::UserCreateCommand.new(user_id: id, first_name: "Adam", last_name: "Jensen")
    user_created = an_event(Account::UserCreatedEvent)

    Account::OnUserCreate.new.call(command)

    expect(event_store).to have_published(user_created)
  end

end