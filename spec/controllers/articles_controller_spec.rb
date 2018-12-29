# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArticlesController, type: :controller do
  context "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "assigns blogging articles" do
      blogging_user = ::BlogManagement::UserReadModel.create!(name: "Name")
      blogging_article = ::BlogManagement::ArticleReadModel.create!(title: "A", content: "B", user_id: blogging_user.id)

      get :index
      expect(assigns(:articles)).to eq([blogging_article])
    end
  end
end
