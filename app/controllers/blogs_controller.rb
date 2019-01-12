class BlogsController < ApplicationController
  def create
    command_bus.call(Blogging::BlogCreateCommand.new(
      blog_id: SecureRandom.uuid,
      name: blog_params[:name],
      user_id: current_user.id
    ))

    redirect_to articles_path
  end

  def publish
  end

  private

  def current_user
    @user = ::BlogManagement::UserReadModel.last!
  end

  def blog_params
    params.require(:blog).permit(:name)
  end
end
