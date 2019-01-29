# frozen_string_literal: true
require "rails_helper"

RSpec.describe Account::OnUserConfirm do
  it "confirms user" do
    id = SecureRandom.uuid
    ::BlogManagement::UserReadModel.create!(id: id, name: "Name", confirmed: false)
    ::AccountManagement::UserReadModel.create!(id: id)
    event_store = RailsEventStore::Client.new
    command = Account::UserConfirmCommand.new(user_id: id)
    user_confirmed = an_event(Account::UserConfirmedEvent)

    Account::OnUserConfirm.new.call(command)

    expect(event_store).to have_published(user_confirmed)
  end

end