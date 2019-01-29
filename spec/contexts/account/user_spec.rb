# frozen_string_literal: true
require "rails_helper"

RSpec.describe Account::User do
  let(:id) { SecureRandom.uuid }
  subject { described_class.new(id) }
  before do
    Timecop.freeze(Time.local(1990))
  end

  after do
    Timecop.return
  end

  context "#create" do
    it "raises error when first name is missing" do
      expect { subject.create(first_name: "", last_name: "Jensen") }.to raise_error Account::User::FirstNameMissing
    end

    it "creates new user" do
      subject.create(first_name: "Adam", last_name: "Jensen")
      user_created = an_event(Account::UserCreatedEvent)

      expect(subject).to have_applied(user_created).once
    end
  end

  context "#confirm" do
    it "confirms user" do
      subject.confirm
      user_confirmed = an_event(Account::UserConfirmedEvent)

      expect(subject).to have_applied(user_confirmed).once
    end
  end
end