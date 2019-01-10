class UsersController < ApplicationController
  def create
    command_bus.call(Account::UserCreateCommand.new(
      user_id: SecureRandom.uuid,
      first_name: user_params[:first_name],
      last_name: user_params[:last_name],
    ))

    redirect_to articles_path
  end

  def confirm
    command_bus.call(Account::UserConfirmCommand.new(
      user_id: params[:id])
    )

    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
