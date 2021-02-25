class UsersController < ApplicationController

  skip_before_action :authenticate_user!, only: %i[show]

  def show
    @user = User.includes(posts: [:category]).find_by(id: params[:id])
  end
end
