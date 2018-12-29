require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  context "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
