class ArticlesController < ApplicationController
  def index
    @articles = ::BlogManagement::ArticleReadModel.where(user: current_user).all
  end

  def new
    @article = ::BlogManagement::ArticleReadModel.new(user: current_user)
  end

  def create
    command_bus.call(Blogging::ArticleCreateCommand.new(
      article_id: SecureRandom.uuid,
      title: article_params[:title],
      content: article_params[:content],
      user_id: current_user.id
    ))

    redirect_to action: :index
  end

  def publish
    command_bus.call(Blogging::ArticlePublishCommand.new(
      article_id: params[:id],
      blog_id: params[:blog_id],
      user_id: current_user.id
    ))

    redirect_to action: :index
  end

  def update
  end

  def destroy
    command_bus.call(Blogging::ArticleDeleteCommand.new(
      article_id: params[:id],
      user_id: current_user.id
    ))

    redirect_to action: :index
  end

  private

  def current_user
    @user = ::BlogManagement::UserReadModel.first || ::BlogManagement::UserReadModel.create(name: "Name")
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
