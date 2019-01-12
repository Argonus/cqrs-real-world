# frozen_string_literal: true

require "rails_helper"

RSpec.describe BlogsController, type: :controller do
  context "POST #create" do
    it "creates article" do
      blogging_user = ::BlogManagement::UserReadModel.create!(name: "Name")
      params = {
        blog: {
          name: "A",
        }
      }

      post :create, params: params
      blog = ::BlogManagement::BlogReadModel.find_by(name: "A")

      expect(blog.name).to eq "A"
      expect(blog.user_id).to eq blogging_user.id
    end
  end
  #
  # context "PATCH #publish" do
  #   it "deletes article" do
  #   end
  # end
end
