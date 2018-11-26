class PlayersController < ApplicationController
  def create
    post = service.create(create_params)

    render json: post, status: :created
  end

  private

  def service
    PlayerService.new
  end

  def create_params
    params.require(:player).permit(:name)
  end
end
