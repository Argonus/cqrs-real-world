# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArticlesController, type: :controller do
  context "GET #index" do
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

  context "POST #create" do
    it "creates article" do
      blogging_user = ::BlogManagement::UserReadModel.create!(name: "Name")
      params = {
        article: {
          title: "A",
          content: "B"
        }
      }

      post :create, params: params
      article = ::BlogManagement::ArticleReadModel.find_by(title: "A")

      expect(article.content).to eq "B"
      expect(article.user_id).to eq blogging_user.id
    end
  end

  context "DELETE #destroy" do
    it "deletes article" do
      blogging_user = ::BlogManagement::UserReadModel.create!(name: "Name")
      blogging_article = ::BlogManagement::ArticleReadModel.create!(title: "A", content: "B", user_id: blogging_user.id)

      expect do
        delete :destroy, params: {id: blogging_article.id}
      end.to change(::BlogManagement::ArticleReadModel, :count).by(-1)
    end
  end
end
