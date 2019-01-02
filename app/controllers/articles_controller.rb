class ArticlesController < ApplicationController
  def index
    @articles = ::BlogManagement::ArticleReadModel.where(user: current_user).all
  end

  def new
    @article = ::BlogManagement::ArticleReadModel.new(user: current_user)
  end

  def create
    command_bus.call(Blogging::ArticleCreatedCommand.new(
      article_id: SecureRandom.uuid,
      title: article_params[:title],
      content: article_params[:content],
      user_id: params[:user_id]
    ))

    redirect_to action: :index
  end

  def publish
  end

  def update
  end

  def destroy
  end

  private

  def current_user
    @user = ::BlogManagement::UserReadModel.first!
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
