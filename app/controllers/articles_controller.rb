class ArticlesController < ApplicationController
  def index
    @articles = ::BlogManagement::ArticleReadModel.all
  end

  def create
    user = BlogManagement::UserReadModel.first!
    command_bus.call(Blogging::ArticleCreatedCommand.new(
      article_id: SecureRandom.uuid,
      title: params[:title],
      content: params[:content],
      user_id: user.id
    ))
  end
end
