class PlayersController < ApplicationController
  def create
    @player = player_creator_service.call

    render 'players/create', status: :created
  end

  private

  def player_creator_service
    Player::CreatorService.new(create_params)
  end

  def create_params
    params.require(:player).permit(:name)
  end
end
