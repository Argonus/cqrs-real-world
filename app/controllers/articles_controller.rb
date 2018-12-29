class ArticlesController < ApplicationController
  def index
    @articles = ::BlogManagement::ArticleReadModel.all
  end
end
