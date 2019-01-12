# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  context "POST #create" do
    it "creates users in both contexts" do
      params = {
        user: {
          first_name: "John",
          last_name: "Dow"
        }
      }

      post :create, params: params

      # account context
      user = ::AccountManagement::UserReadModel.last

      expect(user.first_name).to eq "John"
      expect(user.last_name).to eq "Dow"

      # blogging context
      user = ::BlogManagement::UserReadModel.last

      expect(user.name).to eq "John Dow"
    end
  end

  context "PATCH #confirm" do
    it "confirms user in all contexts" do
      account_user = ::AccountManagement::UserReadModel.create!(first_name: "Name", confirmed_at: nil)
      blog_user = ::BlogManagement::UserReadModel.create!(id: account_user.id, name: "Name", confirmed: false)

      patch :confirm, params: {id: account_user.id}

      blog_user.reload
      account_user.reload

      expect(blog_user.confirmed).to eq true
      expect(account_user.confirmed_at).not_to be_nil
    end
  end
end
