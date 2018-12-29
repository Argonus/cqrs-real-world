class ArticlesController < ApplicationController
  def index
    @articles = ::BlogManagement::ArticleReadModel.all
  end

  def publish
    user = BlogManagement::UserReadModel.first!
    command_bus.call(Blogging::ArticlePublishedCommand.new(
      title: params[:title],
      content: params[:content],
      user_id: user.id
    ))
  end
end
