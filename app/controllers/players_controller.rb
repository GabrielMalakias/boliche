class PlayersController < ApplicationController
  def create
    @player = service.create(create_params)

    render 'players/create', status: :created
  end

  private

  def service
    PlayerService.new
  end

  def create_params
    params.require(:player).permit(:name)
  end
end
